


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE EXTENSION IF NOT EXISTS "pg_cron" WITH SCHEMA "pg_catalog";






CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE TYPE "public"."disziplin" AS ENUM (
    '8-ball',
    '9-ball',
    '10-ball',
    'multi-ball',
    '14-1'
);


ALTER TYPE "public"."disziplin" OWNER TO "postgres";


CREATE TYPE "public"."partie_status" AS ENUM (
    'geplant',
    'laeuft',
    'beendet',
    'abgebrochen'
);


ALTER TYPE "public"."partie_status" OWNER TO "postgres";


CREATE TYPE "public"."personen_status" AS ENUM (
    'mitglied',
    'gast',
    'ausgetreten'
);


ALTER TYPE "public"."personen_status" OWNER TO "postgres";


CREATE TYPE "public"."rating_quelle" AS ENUM (
    'eigene-daten',
    'vorlaeufig',
    'andere-disziplin',
    'startwert',
    'vereinsschnitt',
    'von-hand',
    'gast'
);


ALTER TYPE "public"."rating_quelle" OWNER TO "postgres";


CREATE TYPE "public"."rolle" AS ENUM (
    'vereinsadmin',
    'sportwart',
    'turnierleiter',
    'mitglied'
);


ALTER TYPE "public"."rolle" OWNER TO "postgres";


CREATE TYPE "public"."turnier_modus" AS ENUM (
    'einzelgruppe',
    'zwei-gruppen',
    'gruppen-ko',
    'einzelspiel',
    'sonstiges',
    'liga'
);


ALTER TYPE "public"."turnier_modus" OWNER TO "postgres";


CREATE TYPE "public"."turnier_status" AS ENUM (
    'geplant',
    'laeuft',
    'beendet',
    'abgebrochen'
);


ALTER TYPE "public"."turnier_status" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."admin_selbstsperre"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if current_setting('cuedesk.verein_loeschen', true) = 'an' then
    return old;
  end if;
  if old.rolle = 'vereinsadmin' and old.benutzer_id = auth.uid() then
    raise exception 'Die Rolle Vereins-Administrator kann man sich nicht selbst entziehen.';
  end if;
  return old;
end;
$$;


ALTER FUNCTION "public"."admin_selbstsperre"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."aenderung_protokollieren"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_alt jsonb;
  v_neu jsonb;
  v_satz jsonb;
begin
  if tg_op <> 'INSERT' then v_alt := to_jsonb(old); end if;
  if tg_op <> 'DELETE' then v_neu := to_jsonb(new); end if;
  v_satz := coalesce(v_neu, v_alt);
  insert into public.aenderungen (benutzer_id, verein_id, tabelle, datensatz_id, aktion, vorher, nachher)
  values (
    auth.uid(),
    case when tg_table_name = 'vereine' then (v_satz ->> 'id')::uuid else (v_satz ->> 'verein_id')::uuid end,
    tg_table_name,
    case
      when tg_table_name = 'turnier_teilnehmer' then (v_satz ->> 'turnier_id') || ':' || (v_satz ->> 'person_id')
      else coalesce(v_satz ->> 'id', v_satz ->> 'benutzer_id')
    end,
    lower(tg_op),
    v_alt,
    v_neu
  );
  return coalesce(new, old);
end;
$$;


ALTER FUNCTION "public"."aenderung_protokollieren"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."anmeldung_mitschreiben"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if new.last_sign_in_at is distinct from old.last_sign_in_at then
    update public.benutzer set angemeldet_am = new.last_sign_in_at where id = new.id;
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."anmeldung_mitschreiben"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."aufraeumen"("p_arten" "text"[]) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_vorher jsonb;
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur für Super-Admins.';
  end if;
  v_vorher := public.aufraeumen_intern(false, '{}');
  perform public.aufraeumen_intern(true, p_arten);
  perform public.protokollieren('aufgeraeumt', null,
    (select jsonb_object_agg(k, v_vorher -> k) from unnest(p_arten) k));
  return v_vorher;
end;
$$;


ALTER FUNCTION "public"."aufraeumen"("p_arten" "text"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."aufraeumen_intern"("p_ausfuehren" boolean, "p_arten" "text"[]) RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v   jsonb := '{}'::jsonb;
  n   integer;
begin
  -- Kopplungscodes gelten 15 Minuten
  if p_ausfuehren and 'kopplungen' = any(p_arten) then
    delete from public.kopplungen where erstellt_am < now() - interval '15 minutes';
  end if;
  select count(*) into n from public.kopplungen where erstellt_am < now() - interval '15 minutes';
  v := v || jsonb_build_object('kopplungen', n);

  -- Tablet-Anmeldungen ohne Geraet (entfernte Tablets, abgebrochene Kopplungen)
  if p_ausfuehren and 'tablet_konten' = any(p_arten) then
    delete from auth.users u
     where u.is_anonymous and u.created_at < now() - interval '1 day'
       and not exists (select 1 from public.geraete g where g.auth_id = u.id);
  end if;
  select count(*) into n from auth.users u
   where u.is_anonymous and u.created_at < now() - interval '1 day'
     and not exists (select 1 from public.geraete g where g.auth_id = u.id);
  v := v || jsonb_build_object('tablet_konten', n);

  -- Tablets, die sich seit 90 Tagen nicht gemeldet haben
  if p_ausfuehren and 'tablets_alt' = any(p_arten) then
    delete from auth.users u using public.geraete g
     where g.auth_id = u.id and coalesce(g.zuletzt_gesehen, g.erstellt_am) < now() - interval '90 days';
    delete from public.geraete g where coalesce(g.zuletzt_gesehen, g.erstellt_am) < now() - interval '90 days';
  end if;
  select count(*) into n from public.geraete g
   where coalesce(g.zuletzt_gesehen, g.erstellt_am) < now() - interval '90 days';
  v := v || jsonb_build_object('tablets_alt', n);

  -- Einladungen, die 30 Tage niemand angenommen hat
  if p_ausfuehren and 'einladungen' = any(p_arten) then
    delete from public.einladungen where angenommen_am is null and erstellt_am < now() - interval '30 days';
  end if;
  select count(*) into n from public.einladungen where angenommen_am is null and erstellt_am < now() - interval '30 days';
  v := v || jsonb_build_object('einladungen', n);

  -- Tischstaende, die seit 14 Tagen niemand geaendert hat
  if p_ausfuehren and 'tischstaende' = any(p_arten) then
    delete from public.live_stand where aktualisiert < now() - interval '14 days';
  end if;
  select count(*) into n from public.live_stand where aktualisiert < now() - interval '14 days';
  v := v || jsonb_build_object('tischstaende', n);

  -- Aenderungsprotokoll aelter als zwei Jahre
  if p_ausfuehren and 'aenderungen' = any(p_arten) then
    delete from public.aenderungen where zeitpunkt < now() - interval '2 years';
  end if;
  select count(*) into n from public.aenderungen where zeitpunkt < now() - interval '2 years';
  v := v || jsonb_build_object('aenderungen', n);

  -- Aenderungsprotokoll von Vereinen, die es nicht mehr gibt
  if p_ausfuehren and 'aenderungen_verwaist' = any(p_arten) then
    delete from public.aenderungen a
     where a.verein_id is not null
       and not exists (select 1 from public.vereine v where v.id = a.verein_id);
  end if;
  select count(*) into n from public.aenderungen a
   where a.verein_id is not null
     and not exists (select 1 from public.vereine v where v.id = a.verein_id);
  v := v || jsonb_build_object('aenderungen_verwaist', n);

  -- Rueckmeldungen der Sicherung aelter als ein Jahr
  if p_ausfuehren and 'ereignisse' = any(p_arten) then
    delete from public.system_ereignisse where zeit < now() - interval '1 year';
  end if;
  select count(*) into n from public.system_ereignisse where zeit < now() - interval '1 year';
  v := v || jsonb_build_object('ereignisse', n);

  return v;
end;
$$;


ALTER FUNCTION "public"."aufraeumen_intern"("p_ausfuehren" boolean, "p_arten" "text"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."aufraeumen_vorschau"() RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur für Super-Admins.';
  end if;
  return public.aufraeumen_intern(false, '{}');
end;
$$;


ALTER FUNCTION "public"."aufraeumen_vorschau"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."darf_einladen"("p_verein" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select public.hat_rolle(p_verein, '{vereinsadmin,sportwart}')
      or exists (
        select 1
        from public.benutzer_rechte r
        join public.benutzer b on b.id = r.benutzer_id
        join public.vereine v on v.id = r.verein_id
        where r.benutzer_id = auth.uid() and b.aktiv and v.aktiv
          and r.verein_id = p_verein and r.darf_einladen
      );
$$;


ALTER FUNCTION "public"."darf_einladen"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."demo_zuruecksetzen"("p_verein" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_personen uuid[] := '{}';
  v_id       uuid;
  v_turnier  uuid;
  v_tische   uuid[];
  v_vor      text[] := array['Anna','Bernd','Carla','Dirk','Elke','Frank','Greta','Hauke','Ines','Jens','Kerstin','Lars'];
  v_nach     text[] := array['Albers','Brandt','Claussen','Dierks','Ehlers','Fricke','Garbers','Hollmann','Imken','Janssen','Kruse','Lüdemann'];
  v_start    int[]  := array[720, 690, 660, 640, 610, 590, 560, 540, 520, 500, 470, 450];
  i int; r int; k int;
  a int; b int; n int := 6;
  v_kreis int[];
  v_sieger int; v_rest int;
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur für Super-Admins.';
  end if;
  if not exists (select 1 from public.vereine where id = p_verein and ist_test) then
    raise exception 'Demo zurücksetzen geht nur bei Test-Vereinen.';
  end if;

  delete from public.live_stand          where verein_id = p_verein;
  delete from public.aufnahmen_141       where verein_id = p_verein;
  delete from public.partien_141         where verein_id = p_verein;
  delete from public.partien             where verein_id = p_verein;
  delete from public.turnier_teilnehmer  where verein_id = p_verein;
  delete from public.turniere            where verein_id = p_verein;
  delete from public.serien              where verein_id = p_verein;
  delete from public.mannschaft_spieler  where verein_id = p_verein;
  delete from public.mannschaften        where verein_id = p_verein;
  delete from public.rating_stand        where verein_id = p_verein;
  delete from public.einladungen         where verein_id = p_verein and angenommen_am is null;
  delete from public.personen p
   where p.verein_id = p_verein
     and not exists (select 1 from public.benutzer_personen bp where bp.person_id = p.id);
  delete from public.aenderungen where verein_id = p_verein;

  -- 12 erfundene Spieler, die letzten zwei als Gaeste
  for i in 1..12 loop
    insert into public.personen (verein_id, vorname, nachname, status, name_oeffentlich)
    values (p_verein, v_vor[i], v_nach[i], (case when i > 10 then 'gast' else 'mitglied' end)::public.personen_status, true)
    returning id into v_id;
    insert into public.personen_intern (person_id, verein_id, eintritt, rating_startwert)
    values (v_id, p_verein, current_date - (i * 97), v_start[i]);
    v_personen := v_personen || v_id;
  end loop;

  -- Tische nur, wenn es noch keine gibt
  if not exists (select 1 from public.tische where verein_id = p_verein) then
    insert into public.tische (verein_id, nummer, bezeichnung)
    select p_verein, x, 'Tisch ' || x from generate_series(1, 4) x;
  end if;
  select array_agg(id order by nummer) into v_tische from public.tische where verein_id = p_verein;

  -- Beendetes 8-Ball-Turnier: 6 Spieler, jeder gegen jeden, Race to 4
  insert into public.turniere (verein_id, name, datum, disziplin, modus, status, rating_werten,
                               eingefroren_am, teilnehmerzahl, einstellungen)
  values (p_verein, 'Demo-Turnier 8-Ball', current_date - 14, '8-ball', 'einzelgruppe', 'beendet', true,
          now() - interval '14 days', n,
          '{"raceTo": 4, "vorgabe": {"aktiv": false, "staerke": 75, "obergrenze": 0}}'::jsonb)
  returning id into v_turnier;
  for i in 1..n loop
    insert into public.turnier_teilnehmer (turnier_id, person_id, verein_id, startnummer,
                                           rating_eingefroren, rating_quelle)
    values (v_turnier, v_personen[i], p_verein, i, v_start[i], 'startwert');
  end loop;

  -- Rundenplan nach dem Kreisverfahren; meist gewinnt der Staerkere,
  -- 3 der 15 Spiele sind Ueberraschungen.
  v_kreis := array[1, 2, 3, 4, 5, 6];
  for r in 1..n - 1 loop
    for k in 1..n / 2 loop
      a := v_kreis[k];
      b := v_kreis[n + 1 - k];
      v_sieger := case when (a + 2 * b + r) % 5 = 0 then greatest(a, b) else least(a, b) end;
      v_rest := (a * 7 + b * 3 + r) % 4;
      insert into public.partien (verein_id, turnier_id, disziplin, datum, phase, runde, paarung, tisch_id,
                                  spieler_a, spieler_b, race_to, ergebnis_a, ergebnis_b, status,
                                  rating_werten, begonnen, beendet)
      values (p_verein, v_turnier, '8-ball', current_date - 14, 'gruppe', r, k, v_tische[1 + (k - 1) % cardinality(v_tische)],
              v_personen[a], v_personen[b], 4,
              case when v_sieger = a then 4 else v_rest end,
              case when v_sieger = b then 4 else v_rest end,
              'beendet', true,
              (current_date - 14) + time '19:00' + (r * interval '40 minutes'),
              (current_date - 14) + time '19:30' + (r * interval '40 minutes'));
    end loop;
    -- Kreis drehen, der erste bleibt stehen
    v_kreis := array[v_kreis[1], v_kreis[n]] || v_kreis[2:n - 1];
  end loop;

  -- Endplaetze nach Siegen, dann Spieldifferenz
  update public.turnier_teilnehmer t set endplatz = s.platz
    from (
      select x.person_id, row_number() over (order by sum(x.sieg) desc, sum(x.diff) desc) as platz
        from (
          select spieler_a as person_id, (ergebnis_a > ergebnis_b)::int as sieg, ergebnis_a - ergebnis_b as diff
            from public.partien where turnier_id = v_turnier
          union all
          select spieler_b, (ergebnis_b > ergebnis_a)::int, ergebnis_b - ergebnis_a
            from public.partien where turnier_id = v_turnier
        ) x group by x.person_id
    ) s
   where t.turnier_id = v_turnier and t.person_id = s.person_id;

  -- Geplantes 9-Ball-Turnier zum Ausprobieren, 8 Anmeldungen
  insert into public.turniere (verein_id, name, datum, disziplin, modus, status, einstellungen)
  values (p_verein, 'Demo-Turnier 9-Ball', current_date + 7, '9-ball', 'einzelgruppe', 'geplant',
          '{"raceTo": 5, "vorgabe": {"aktiv": true, "staerke": 75, "obergrenze": 0}}'::jsonb)
  returning id into v_turnier;
  for i in 3..10 loop
    insert into public.turnier_teilnehmer (turnier_id, person_id, verein_id)
    values (v_turnier, v_personen[i], p_verein);
  end loop;

  perform public.protokollieren('demo_zurueckgesetzt', p_verein, '{}'::jsonb);
end;
$$;


ALTER FUNCTION "public"."demo_zuruecksetzen"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."einladung_sofort"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_benutzer uuid;
begin
  select id into v_benutzer from public.benutzer where email = new.email;
  if v_benutzer is not null then
    perform public.einladungen_uebernehmen(v_benutzer, new.email);
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."einladung_sofort"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."einladungen_uebernehmen"("p_benutzer" "uuid", "p_email" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  e record;
begin
  for e in
    select * from public.einladungen
    where email = lower(p_email) and angenommen_am is null
  loop
    insert into public.benutzer_rollen (benutzer_id, verein_id, rolle)
      select p_benutzer, e.verein_id, unnest(e.rollen)
      on conflict do nothing;
    if e.person_id is not null then
      insert into public.benutzer_personen (benutzer_id, verein_id, person_id)
        values (p_benutzer, e.verein_id, e.person_id)
        on conflict do nothing;
    end if;
    update public.einladungen set angenommen_am = now() where id = e.id;
  end loop;
end;
$$;


ALTER FUNCTION "public"."einladungen_uebernehmen"("p_benutzer" "uuid", "p_email" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geaendert_am_setzen"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  new.geaendert_am := now();
  return new;
end;
$$;


ALTER FUNCTION "public"."geaendert_am_setzen"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geraet_koppeln"("p_code" "text", "p_verein" "uuid", "p_name" "text", "p_tisch" "uuid" DEFAULT NULL::"uuid") RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_auth uuid;
  v_id   uuid;
begin
  if not public.hat_rolle(p_verein, '{vereinsadmin,turnierleiter}') then
    raise exception 'Keine Berechtigung';
  end if;
  select auth_id into v_auth from public.kopplungen
    where code = upper(p_code) and erstellt_am > now() - interval '15 minutes';
  if v_auth is null then
    raise exception 'Code unbekannt oder abgelaufen';
  end if;
  insert into public.geraete (verein_id, auth_id, name, tisch_id)
    values (p_verein, v_auth, p_name, p_tisch)
    returning id into v_id;
  delete from public.kopplungen where auth_id = v_auth;
  return v_id;
end;
$$;


ALTER FUNCTION "public"."geraet_koppeln"("p_code" "text", "p_verein" "uuid", "p_name" "text", "p_tisch" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geraet_meldet_sich"() RETURNS "void"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  update public.geraete set zuletzt_gesehen = now() where auth_id = auth.uid();
$$;


ALTER FUNCTION "public"."geraet_meldet_sich"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geraet_neu_geladen"() RETURNS "void"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  update public.geraete set neu_laden_am = null where auth_id = auth.uid();
$$;


ALTER FUNCTION "public"."geraet_neu_geladen"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geraet_tisch_setzen"("p_tisch" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_verein uuid;
begin
  select verein_id into v_verein from public.geraete where auth_id = auth.uid() and aktiv;
  if v_verein is null then
    raise exception 'Geraet ist nicht gekoppelt';
  end if;
  if p_tisch is not null and not exists (
    select 1 from public.tische t where t.id = p_tisch and t.verein_id = v_verein and t.aktiv
  ) then
    raise exception 'Tisch gehoert nicht zu diesem Verein';
  end if;
  update public.geraete
     set tisch_id = p_tisch, zuletzt_gesehen = now()
   where auth_id = auth.uid();
end;
$$;


ALTER FUNCTION "public"."geraet_tisch_setzen"("p_tisch" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."geraet_verein"() RETURNS "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select g.verein_id
  from public.geraete g
  join public.vereine v on v.id = g.verein_id
  where g.auth_id = auth.uid() and g.aktiv and v.aktiv;
$$;


ALTER FUNCTION "public"."geraet_verein"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."hat_rolle"("p_verein" "uuid", "p_rollen" "public"."rolle"[]) RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select exists (
    select 1
    from public.benutzer_rollen r
    join public.benutzer b on b.id = r.benutzer_id
    join public.vereine v on v.id = r.verein_id
    where r.benutzer_id = auth.uid() and b.aktiv and v.aktiv
      and r.verein_id = p_verein and r.rolle = any (p_rollen)
  );
$$;


ALTER FUNCTION "public"."hat_rolle"("p_verein" "uuid", "p_rollen" "public"."rolle"[]) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."ist_eigene_person"("p_person" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select exists (
    select 1
    from public.benutzer_personen bp
    join public.vereine v on v.id = bp.verein_id
    where bp.benutzer_id = auth.uid() and bp.person_id = p_person and v.aktiv
  );
$$;


ALTER FUNCTION "public"."ist_eigene_person"("p_person" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."ist_im_verein"("p_verein" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select public.hat_rolle(p_verein, '{vereinsadmin,sportwart,turnierleiter,mitglied}')
      or public.geraet_verein() = p_verein;
$$;


ALTER FUNCTION "public"."ist_im_verein"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."ist_systemadmin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select coalesce((select b.systemadmin and b.aktiv from public.benutzer b where b.id = auth.uid()), false);
$$;


ALTER FUNCTION "public"."ist_systemadmin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."konsole_datenbank"() RETURNS "jsonb"
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur fuer Super-Admins.';
  end if;
  return jsonb_build_object(
    'groesse_bytes', pg_database_size(current_database()),
    'verbindungen', (select count(*) from pg_catalog.pg_stat_activity where datname = current_database()),
    'tabellen', (
      select coalesce(jsonb_agg(t order by t.bytes desc), '[]'::jsonb) from (
        select c.relname as name, pg_total_relation_size(c.oid) as bytes, c.reltuples::bigint as zeilen
        from pg_catalog.pg_class c join pg_catalog.pg_namespace n on n.oid = c.relnamespace
        where n.nspname = 'public' and c.relkind = 'r'
        order by pg_total_relation_size(c.oid) desc
        limit 8
      ) t),
    'rating_laeufe', (
      select coalesce(jsonb_agg(l order by l.start desc), '[]'::jsonb) from (
        select d.status, d.start_time as start, d.end_time as ende, left(d.return_message, 200) as meldung
        from cron.job_run_details d join cron.job j on j.jobid = d.jobid
        where j.jobname = 'rating-nachts'
        order by d.start_time desc
        limit 5
      ) l)
  );
end;
$$;


ALTER FUNCTION "public"."konsole_datenbank"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."konsole_vereine"() RETURNS TABLE("verein_id" "uuid", "konten" integer, "letzte_anmeldung" timestamp with time zone, "mitglieder" integer, "gaeste" integer, "turniere_30" integer, "partien_30" integer, "partien_gesamt" integer, "tablets" integer, "tablets_online" integer, "datensaetze" bigint)
    LANGUAGE "plpgsql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur fuer Super-Admins.';
  end if;
  return query
  select v.id,
    (select count(distinct r.benutzer_id)::int from public.benutzer_rollen r where r.verein_id = v.id),
    (select max(b.angemeldet_am) from public.benutzer b
       join public.benutzer_rollen r on r.benutzer_id = b.id where r.verein_id = v.id),
    (select count(*)::int from public.personen p where p.verein_id = v.id and p.status = 'mitglied'),
    (select count(*)::int from public.personen p where p.verein_id = v.id and p.status = 'gast'),
    (select count(*)::int from public.turniere t where t.verein_id = v.id and t.datum >= current_date - 30),
    (select count(*)::int from public.partien p where p.verein_id = v.id and p.status = 'beendet'
       and coalesce(p.beendet::date, p.datum) >= current_date - 30),
    (select count(*)::int from public.partien p where p.verein_id = v.id),
    (select count(*)::int from public.geraete g where g.verein_id = v.id and g.aktiv),
    (select count(*)::int from public.geraete g where g.verein_id = v.id and g.aktiv
       and g.zuletzt_gesehen > now() - interval '2 minutes'),
    (select (select count(*) from public.personen x where x.verein_id = v.id)
          + (select count(*) from public.turniere x where x.verein_id = v.id)
          + (select count(*) from public.partien x where x.verein_id = v.id)
          + (select count(*) from public.aufnahmen_141 x where x.verein_id = v.id)
          + (select count(*) from public.rating_stand x where x.verein_id = v.id)
          + (select count(*) from public.aenderungen x where x.verein_id = v.id))::bigint
  from public.vereine v;
end;
$$;


ALTER FUNCTION "public"."konsole_vereine"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."kopplung_anfordern"() RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_code text;
begin
  if auth.uid() is null then
    raise exception 'Nicht angemeldet';
  end if;
  delete from public.kopplungen where erstellt_am < now() - interval '15 minutes';
  loop
    v_code := substr(translate(upper(encode(extensions.gen_random_bytes(8), 'base64')), '+/=0O1I', ''), 1, 6);
    exit when length(v_code) = 6 and not exists (select 1 from public.kopplungen where code = v_code);
  end loop;
  insert into public.kopplungen (code, auth_id) values (v_code, auth.uid())
    on conflict (auth_id) do update set code = excluded.code, erstellt_am = now();
  return v_code;
end;
$$;


ALTER FUNCTION "public"."kopplung_anfordern"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."meine_vereine"() RETURNS TABLE("id" "uuid", "name" "text", "kurzname" "text", "logo_url" "text", "aktiv" boolean, "sperrgrund" "text", "rollen" "public"."rolle"[])
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select v.id, v.name, v.kurzname, v.logo_url, v.aktiv, v.sperrgrund, array_agg(r.rolle order by r.rolle)
  from public.benutzer_rollen r
  join public.benutzer b on b.id = r.benutzer_id and b.aktiv
  join public.vereine v on v.id = r.verein_id
  where r.benutzer_id = auth.uid()
  group by v.id
  order by v.name;
$$;


ALTER FUNCTION "public"."meine_vereine"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."neues_konto"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if coalesce(new.is_anonymous, false) then
    return new;
  end if;
  insert into public.benutzer (id, email) values (new.id, lower(new.email))
    on conflict (id) do nothing;
  perform public.einladungen_uebernehmen(new.id, new.email);
  return new;
end;
$$;


ALTER FUNCTION "public"."neues_konto"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."protokollieren"("p_aktion" "text", "p_verein" "uuid", "p_details" "jsonb") RETURNS "void"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  insert into public.system_protokoll (benutzer_id, aktion, verein_id, details)
  values (
    auth.uid(), p_aktion, p_verein,
    -- ein mitgegebener Name hat Vorrang
    coalesce((select jsonb_build_object('name', v.name) from public.vereine v where v.id = p_verein), '{}'::jsonb)
      || coalesce(p_details, '{}'::jsonb)
  );
$$;


ALTER FUNCTION "public"."protokollieren"("p_aktion" "text", "p_verein" "uuid", "p_details" "jsonb") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rating_nachts"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_schluessel text;
  v_adresse    text;
begin
  select decrypted_secret into v_schluessel
    from vault.decrypted_secrets where name = 'dienstschluessel';
  select decrypted_secret into v_adresse
    from vault.decrypted_secrets where name = 'funktionsadresse';

  if v_schluessel is null or v_adresse is null then
    raise exception 'Im Vault fehlen die Eintraege dienstschluessel und funktionsadresse.';
  end if;

  perform net.http_post(
    url     := v_adresse || '/rating',
    headers := jsonb_build_object(
                 'Content-Type', 'application/json',
                 'Authorization', 'Bearer ' || v_schluessel
               ),
    body    := '{}'::jsonb
  );
end;
$$;


ALTER FUNCTION "public"."rating_nachts"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rls_auto_enable"() RETURNS "event_trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."rls_auto_enable"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."schutzwort_setzen"("p_verein" "uuid", "p_wort" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.hat_rolle(p_verein, '{vereinsadmin}') then
    raise exception 'Das Schutzwort darf nur der Vereins-Administrator ändern.';
  end if;
  insert into public.verein_schutzwort (verein_id, wort)
  values (p_verein, btrim(p_wort))
  on conflict (verein_id) do update set wort = excluded.wort, geaendert_am = now();
end;
$$;


ALTER FUNCTION "public"."schutzwort_setzen"("p_verein" "uuid", "p_wort" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."schutzwort_stimmt"("p_verein" "uuid", "p_wort" "text") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select public.hat_rolle(p_verein, '{vereinsadmin,sportwart,turnierleiter,mitglied}')
     and lower(btrim(p_wort)) = coalesce(
           (select lower(btrim(s.wort)) from public.verein_schutzwort s where s.verein_id = p_verein),
           '8-ball');
$$;


ALTER FUNCTION "public"."schutzwort_stimmt"("p_verein" "uuid", "p_wort" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."support_beenden"("p_verein" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.hat_rolle(p_verein, '{vereinsadmin}') then
    raise exception 'Den Support-Zugang beendet nur der Vereins-Administrator.';
  end if;
  update public.support_freigaben set beendet_am = now()
   where verein_id = p_verein and beendet_am is null;
  perform public.protokollieren('support_beendet', p_verein, '{}'::jsonb);
end;
$$;


ALTER FUNCTION "public"."support_beenden"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."support_freigeben"("p_verein" "uuid", "p_tage" integer) RETURNS timestamp with time zone
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_bis timestamptz := now() + make_interval(days => p_tage);
begin
  if not public.hat_rolle(p_verein, '{vereinsadmin}') then
    raise exception 'Den Support-Zugang gibt nur der Vereins-Administrator frei.';
  end if;
  if p_tage not between 1 and 7 then
    raise exception 'Der Support-Zugang gilt 1 bis 7 Tage.';
  end if;
  update public.support_freigaben set beendet_am = now()
   where verein_id = p_verein and beendet_am is null;
  insert into public.support_freigaben (verein_id, bis, erteilt_von) values (p_verein, v_bis, auth.uid());
  perform public.protokollieren('support_freigegeben', p_verein, jsonb_build_object('bis', v_bis));
  return v_bis;
end;
$$;


ALTER FUNCTION "public"."support_freigeben"("p_verein" "uuid", "p_tage" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."support_freigegeben"("p_verein" "uuid") RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
  select public.ist_systemadmin() and exists (
    select 1 from public.support_freigaben f
    where f.verein_id = p_verein and f.beendet_am is null and f.bis > now()
  );
$$;


ALTER FUNCTION "public"."support_freigegeben"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."systemadmin_setzen"("p_email" "text", "p_ja" boolean) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_konto uuid;
begin
  if not public.ist_systemadmin() then
    raise exception 'Das darf nur ein Super-Admin.';
  end if;
  select b.id into v_konto from public.benutzer b where lower(b.email) = lower(btrim(p_email));
  if v_konto is null then
    raise exception 'Zu dieser Adresse gibt es kein Konto. Die Person muss sich zuerst einmal anmelden oder eingeladen werden.';
  end if;
  if not p_ja and (select count(*) from public.benutzer where systemadmin and aktiv and id <> v_konto) = 0 then
    raise exception 'Der letzte Super-Admin kann nicht entfernt werden.';
  end if;
  update public.benutzer set systemadmin = p_ja where id = v_konto;
  perform public.protokollieren(case when p_ja then 'systemadmin_ernannt' else 'systemadmin_entzogen' end,
                                null, jsonb_build_object('email', lower(btrim(p_email))));
end;
$$;


ALTER FUNCTION "public"."systemadmin_setzen"("p_email" "text", "p_ja" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_anlegen"("p_name" "text", "p_kurzname" "text", "p_slug" "text", "p_test" boolean) RETURNS "uuid"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $_$
declare
  v_id uuid;
begin
  if not public.ist_systemadmin() then
    raise exception 'Vereine legt nur ein Super-Admin an.';
  end if;
  if length(btrim(p_name)) < 2 then
    raise exception 'Der Verein braucht einen Namen.';
  end if;
  if p_slug !~ '^[a-z0-9-]{2,30}$' then
    raise exception 'Die Adresse besteht aus 2 bis 30 Kleinbuchstaben, Ziffern und Bindestrichen.';
  end if;
  insert into public.vereine (name, kurzname, slug, ist_test)
  values (btrim(p_name), coalesce(nullif(btrim(p_kurzname), ''), btrim(p_name)), p_slug, coalesce(p_test, false))
  returning id into v_id;
  perform public.protokollieren('verein_angelegt', v_id,
                                jsonb_build_object('name', btrim(p_name), 'slug', p_slug, 'test', coalesce(p_test, false)));
  return v_id;
end;
$_$;


ALTER FUNCTION "public"."verein_anlegen"("p_name" "text", "p_kurzname" "text", "p_slug" "text", "p_test" boolean) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_endgueltig_loeschen"("p_verein" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_name   text;
  v_konten uuid[];
  v_tablets uuid[];
begin
  select name into v_name from public.vereine where id = p_verein;
  if v_name is null then
    return;
  end if;
  perform set_config('cuedesk.verein_loeschen', 'an', true);

  -- Konten, die nur hier eine Rolle haben und kein Super-Admin sind
  select coalesce(array_agg(distinct r.benutzer_id), '{}') into v_konten
    from public.benutzer_rollen r join public.benutzer b on b.id = r.benutzer_id
   where r.verein_id = p_verein and not b.systemadmin
     and not exists (select 1 from public.benutzer_rollen x
                      where x.benutzer_id = r.benutzer_id and x.verein_id <> p_verein);
  select coalesce(array_agg(auth_id), '{}') into v_tablets
    from public.geraete where verein_id = p_verein and auth_id is not null;

  -- Reihenfolge wegen der Verweise mit "on delete restrict"
  delete from public.live_stand          where verein_id = p_verein;
  delete from public.aufnahmen_141       where verein_id = p_verein;
  delete from public.partien_141         where verein_id = p_verein;
  delete from public.partien             where verein_id = p_verein;
  delete from public.turnier_teilnehmer  where verein_id = p_verein;
  delete from public.turniere            where verein_id = p_verein;
  delete from public.serien              where verein_id = p_verein;
  delete from public.mannschaft_spieler  where verein_id = p_verein;
  delete from public.mannschaften        where verein_id = p_verein;
  delete from public.rating_stand        where verein_id = p_verein;
  delete from public.rating_einstellungen where verein_id = p_verein;
  delete from public.benutzer_personen   where verein_id = p_verein;
  delete from public.einladungen         where verein_id = p_verein;
  delete from public.benutzer_rechte     where verein_id = p_verein;
  delete from public.benutzer_rollen     where verein_id = p_verein;
  delete from public.personen_intern     where verein_id = p_verein;
  delete from public.personen            where verein_id = p_verein;
  delete from public.geraete             where verein_id = p_verein;
  delete from public.tische              where verein_id = p_verein;
  delete from public.vereine             where id = p_verein;   -- Schutzwort, Freigaben per cascade

  delete from auth.users where id = any(v_konten) or id = any(v_tablets);
  -- zuletzt: auch die Eintraege, die das Loeschen eben selbst erzeugt hat
  delete from public.aenderungen where verein_id = p_verein;

  perform public.protokollieren('verein_geloescht', null,
    jsonb_build_object('name', v_name, 'verein', p_verein, 'konten', cardinality(v_konten)));
end;
$$;


ALTER FUNCTION "public"."verein_endgueltig_loeschen"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_entsperren"("p_verein" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Vereine entsperrt nur ein Super-Admin.';
  end if;
  update public.vereine
     set aktiv = true, gesperrt_am = null, sperrgrund = null, loeschen_ab = null
   where id = p_verein;
  perform public.protokollieren('verein_entsperrt', p_verein, '{}'::jsonb);
end;
$$;


ALTER FUNCTION "public"."verein_entsperren"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_export"("p_verein" "uuid") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $_$
declare
  v_verein public.vereine;
  v_daten  jsonb := '{}'::jsonb;
  v_teil   jsonb;
  t        text;
begin
  select * into v_verein from public.vereine where id = p_verein;
  if v_verein.id is null then
    raise exception 'Verein nicht gefunden.';
  end if;
  if not (public.hat_rolle(p_verein, '{vereinsadmin}')
          or (public.ist_systemadmin() and not v_verein.aktiv)) then
    raise exception 'Exportieren darf der Vereins-Administrator, der Super-Admin nur bei einem gesperrten Verein.';
  end if;

  -- Alles, was an verein_id haengt - ohne Aenderungsprotokoll und Tischstaende.
  foreach t in array array[
    'personen', 'personen_intern', 'tische', 'serien', 'turniere', 'turnier_teilnehmer',
    'partien', 'partien_141', 'aufnahmen_141', 'rating_einstellungen', 'rating_stand',
    'mannschaften', 'mannschaft_spieler', 'benutzer_rechte', 'benutzer_personen', 'einladungen'
  ] loop
    execute format('select coalesce(jsonb_agg(to_jsonb(x)), ''[]''::jsonb) from public.%I x where x.verein_id = $1', t)
      into v_teil using p_verein;
    v_daten := v_daten || jsonb_build_object(t, v_teil);
  end loop;

  -- Konten nur mit E-Mail, Name und Rollen im Verein
  v_daten := v_daten || jsonb_build_object('konten', (
    select coalesce(jsonb_agg(jsonb_build_object(
             'email', b.email, 'anzeigename', b.anzeigename,
             'rollen', (select jsonb_agg(r.rolle order by r.rolle) from public.benutzer_rollen r
                         where r.benutzer_id = b.id and r.verein_id = p_verein))), '[]'::jsonb)
      from public.benutzer b
     where exists (select 1 from public.benutzer_rollen r where r.benutzer_id = b.id and r.verein_id = p_verein)));

  -- Tablets ohne ihre Anmeldekennung
  v_daten := v_daten || jsonb_build_object('geraete', (
    select coalesce(jsonb_agg(to_jsonb(g) - 'auth_id'), '[]'::jsonb)
      from public.geraete g where g.verein_id = p_verein));

  update public.vereine set export_am = now() where id = p_verein;
  perform public.protokollieren('verein_exportiert', p_verein, '{}'::jsonb);

  return jsonb_build_object(
    'format', 'cuedesk-export',
    'version', 1,
    'erstellt', now(),
    'verein', to_jsonb(v_verein) - 'export_am' - 'loeschen_ab',
    'daten', v_daten
  );
end;
$_$;


ALTER FUNCTION "public"."verein_export"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_loeschen_abbrechen"("p_verein" "uuid") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Nur für Super-Admins.';
  end if;
  update public.vereine set loeschen_ab = null where id = p_verein;
  perform public.protokollieren('loeschung_abgebrochen', p_verein, '{}'::jsonb);
end;
$$;


ALTER FUNCTION "public"."verein_loeschen_abbrechen"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_loeschen_vormerken"("p_verein" "uuid") RETURNS "date"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v public.vereine;
begin
  if not public.ist_systemadmin() then
    raise exception 'Vereine löscht nur ein Super-Admin.';
  end if;
  select * into v from public.vereine where id = p_verein;
  if v.aktiv then
    raise exception 'Erst sperren, dann löschen.';
  end if;
  if v.export_am is null or v.export_am < v.gesperrt_am then
    raise exception 'Vor dem Löschen die Daten exportieren.';
  end if;
  update public.vereine set loeschen_ab = current_date + 30 where id = p_verein;
  perform public.protokollieren('loeschung_vorgemerkt', p_verein,
                                jsonb_build_object('ab', current_date + 30));
  return current_date + 30;
end;
$$;


ALTER FUNCTION "public"."verein_loeschen_vormerken"("p_verein" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_sofort_loeschen"("p_verein" "uuid", "p_name" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v public.vereine;
begin
  if not public.ist_systemadmin() then
    raise exception 'Vereine löscht nur ein Super-Admin.';
  end if;
  select * into v from public.vereine where id = p_verein;
  if not v.ist_test then
    raise exception 'Sofort löschen geht nur bei Test-Vereinen.';
  end if;
  if v.aktiv then
    raise exception 'Erst sperren, dann löschen.';
  end if;
  if btrim(p_name) is distinct from v.name then
    raise exception 'Der Name stimmt nicht.';
  end if;
  perform public.verein_endgueltig_loeschen(p_verein);
end;
$$;


ALTER FUNCTION "public"."verein_sofort_loeschen"("p_verein" "uuid", "p_name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."verein_sperren"("p_verein" "uuid", "p_grund" "text") RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if not public.ist_systemadmin() then
    raise exception 'Vereine sperrt nur ein Super-Admin.';
  end if;
  update public.vereine
     set aktiv = false, gesperrt_am = now(), sperrgrund = nullif(btrim(p_grund), '')
   where id = p_verein;
  perform public.protokollieren('verein_gesperrt', p_verein, jsonb_build_object('grund', p_grund));
end;
$$;


ALTER FUNCTION "public"."verein_sperren"("p_verein" "uuid", "p_grund" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."vereine_loeschen_faellig"() RETURNS integer
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_id uuid;
  n    integer := 0;
begin
  for v_id in
    select id from public.vereine where not aktiv and loeschen_ab <= current_date
  loop
    perform public.verein_endgueltig_loeschen(v_id);
    n := n + 1;
  end loop;
  return n;
end;
$$;


ALTER FUNCTION "public"."vereine_loeschen_faellig"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."vereine_schutz"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  if auth.uid() is not null and not public.ist_systemadmin() and (
       new.aktiv is distinct from old.aktiv
    or new.ist_test is distinct from old.ist_test
    or new.gesperrt_am is distinct from old.gesperrt_am
    or new.sperrgrund is distinct from old.sperrgrund
    or new.slug is distinct from old.slug
    or new.loeschen_ab is distinct from old.loeschen_ab
  ) then
    raise exception 'Status, Test-Kennzeichen und Adresse eines Vereins ändert nur der Super-Admin.';
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."vereine_schutz"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."aenderungen" (
    "id" bigint NOT NULL,
    "zeitpunkt" timestamp with time zone DEFAULT "now"() NOT NULL,
    "benutzer_id" "uuid",
    "verein_id" "uuid",
    "tabelle" "text" NOT NULL,
    "datensatz_id" "text",
    "aktion" "text" NOT NULL,
    "vorher" "jsonb",
    "nachher" "jsonb"
);


ALTER TABLE "public"."aenderungen" OWNER TO "postgres";


ALTER TABLE "public"."aenderungen" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."aenderungen_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."aufnahmen_141" (
    "id" bigint NOT NULL,
    "partie_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "lfd_nr" integer NOT NULL,
    "spieler" "uuid" NOT NULL,
    "baelle" integer NOT NULL,
    "punkte" integer NOT NULL,
    "gesamt" integer NOT NULL,
    "art" "text" NOT NULL,
    "markierung" "text" DEFAULT ''::"text" NOT NULL,
    "rack_segmente" integer[] DEFAULT '{}'::integer[] NOT NULL,
    "rack_nr" integer DEFAULT 1 NOT NULL,
    "zeitpunkt" timestamp with time zone,
    CONSTRAINT "aufnahmen_141_art_check" CHECK (("art" = ANY (ARRAY['serie'::"text", 'sicherheit'::"text", 'foul'::"text", 'foul3'::"text", 'eroeffnungsfoul'::"text", 'ende'::"text"]))),
    CONSTRAINT "aufnahmen_141_markierung_check" CHECK (("markierung" = ANY (ARRAY[''::"text", '/'::"text", '//'::"text", '3F'::"text", '-2'::"text"])))
);


ALTER TABLE "public"."aufnahmen_141" OWNER TO "postgres";


ALTER TABLE "public"."aufnahmen_141" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."aufnahmen_141_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."benutzer" (
    "id" "uuid" NOT NULL,
    "email" "text",
    "anzeigename" "text",
    "systemadmin" boolean DEFAULT false NOT NULL,
    "aktiv" boolean DEFAULT true NOT NULL,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "angemeldet_am" timestamp with time zone
);


ALTER TABLE "public"."benutzer" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."benutzer_personen" (
    "benutzer_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "person_id" "uuid" NOT NULL
);


ALTER TABLE "public"."benutzer_personen" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."benutzer_rechte" (
    "benutzer_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "darf_einladen" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."benutzer_rechte" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."benutzer_rollen" (
    "benutzer_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "rolle" "public"."rolle" NOT NULL
);


ALTER TABLE "public"."benutzer_rollen" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."einladungen" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "email" "text" NOT NULL,
    "rollen" "public"."rolle"[] DEFAULT '{mitglied}'::"public"."rolle"[] NOT NULL,
    "person_id" "uuid",
    "eingeladen_von" "uuid",
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "angenommen_am" timestamp with time zone,
    CONSTRAINT "einladungen_email_check" CHECK (("email" = "lower"("email")))
);


ALTER TABLE "public"."einladungen" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."geraete" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "auth_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "tisch_id" "uuid",
    "aktiv" boolean DEFAULT true NOT NULL,
    "zuletzt_gesehen" timestamp with time zone,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "neu_laden_am" timestamp with time zone
);


ALTER TABLE "public"."geraete" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."kopplungen" (
    "code" "text" NOT NULL,
    "auth_id" "uuid" NOT NULL,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "kopplungen_code_check" CHECK (("code" ~ '^[A-Z0-9]{6}$'::"text"))
);


ALTER TABLE "public"."kopplungen" OWNER TO "postgres";


COMMENT ON TABLE "public"."kopplungen" IS 'Offene Geraete-Kopplungen. Absichtlich ohne Policy: Zugriff nur ueber kopplung_anfordern() und geraet_koppeln().';



CREATE TABLE IF NOT EXISTS "public"."live_stand" (
    "tisch_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "zustand" "jsonb" NOT NULL,
    "besitzer" "text",
    "aktualisiert" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."live_stand" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."mannschaft_spieler" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "mannschaft_id" "uuid" NOT NULL,
    "person_id" "uuid" NOT NULL,
    "stammspieler" boolean DEFAULT false NOT NULL,
    "kapitaen" boolean DEFAULT false NOT NULL,
    "berechtigt_ab" "date",
    "position" integer,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."mannschaft_spieler" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."mannschaften" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "saison" "text" NOT NULL,
    "liga" "text",
    "staffel" "text",
    "rang" integer DEFAULT 1 NOT NULL,
    "aktiv" boolean DEFAULT true NOT NULL,
    "notiz" "text",
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "geaendert_am" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."mannschaften" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."partien" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "turnier_id" "uuid",
    "disziplin" "public"."disziplin" DEFAULT '8-ball'::"public"."disziplin" NOT NULL,
    "datum" "date" NOT NULL,
    "phase" "text",
    "gruppe" "text",
    "runde" integer,
    "paarung" integer,
    "tisch_id" "uuid",
    "spieler_a" "uuid" NOT NULL,
    "spieler_b" "uuid" NOT NULL,
    "race_to" integer,
    "vorgabe_a" integer DEFAULT 0 NOT NULL,
    "vorgabe_b" integer DEFAULT 0 NOT NULL,
    "ergebnis_a" integer,
    "ergebnis_b" integer,
    "status" "public"."partie_status" DEFAULT 'geplant'::"public"."partie_status" NOT NULL,
    "rating_werten" boolean DEFAULT true NOT NULL,
    "rating_grund" "text",
    "begonnen" timestamp with time zone,
    "beendet" timestamp with time zone,
    "eingetragen_von" "uuid",
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "partien_check" CHECK (("spieler_a" <> "spieler_b")),
    CONSTRAINT "partien_ergebnis_a_check" CHECK ((("ergebnis_a" >= 0) OR ("disziplin" = '14-1'::"public"."disziplin"))),
    CONSTRAINT "partien_ergebnis_b_check" CHECK ((("ergebnis_b" >= 0) OR ("disziplin" = '14-1'::"public"."disziplin"))),
    CONSTRAINT "partien_race_to_check" CHECK (("race_to" > 0)),
    CONSTRAINT "partien_vorgabe_a_check" CHECK (("vorgabe_a" >= 0)),
    CONSTRAINT "partien_vorgabe_b_check" CHECK (("vorgabe_b" >= 0))
);


ALTER TABLE "public"."partien" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."partien_141" (
    "partie_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "ziel_punkte" integer DEFAULT 0 NOT NULL,
    "ziel_aufnahmen" integer DEFAULT 0 NOT NULL,
    "aufnahmen_a" integer DEFAULT 0 NOT NULL,
    "aufnahmen_b" integer DEFAULT 0 NOT NULL,
    "hoechstserie_a" integer DEFAULT 0 NOT NULL,
    "hoechstserie_b" integer DEFAULT 0 NOT NULL,
    "dauer_sek" integer,
    CONSTRAINT "partien_141_dauer_sek_check" CHECK (("dauer_sek" >= 0)),
    CONSTRAINT "partien_141_ziel_aufnahmen_check" CHECK (("ziel_aufnahmen" >= 0)),
    CONSTRAINT "partien_141_ziel_punkte_check" CHECK (("ziel_punkte" >= 0))
);


ALTER TABLE "public"."partien_141" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."personen" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "vorname" "text" NOT NULL,
    "nachname" "text" NOT NULL,
    "anzeigename" "text",
    "kuerzel" "text",
    "status" "public"."personen_status" DEFAULT 'mitglied'::"public"."personen_status" NOT NULL,
    "name_oeffentlich" boolean DEFAULT false NOT NULL,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "geaendert_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "rating_ausgeblendet" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."personen" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."personen_intern" (
    "person_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "eintritt" "date",
    "austritt" "date",
    "minderjaehrig" boolean DEFAULT false NOT NULL,
    "rating_startwert" integer,
    "notiz" "text",
    "passnummer" "text",
    "dbu_nummer" "text",
    CONSTRAINT "personen_intern_rating_startwert_check" CHECK ((("rating_startwert" >= 100) AND ("rating_startwert" <= 1000)))
);


ALTER TABLE "public"."personen_intern" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."rating_einstellungen" (
    "verein_id" "uuid" NOT NULL,
    "zeitraum_monate" integer DEFAULT 12 NOT NULL,
    "mindest_racks" integer DEFAULT 100 NOT NULL,
    "rueckgriff_monate" integer DEFAULT 36 NOT NULL,
    "gewicht" integer DEFAULT 30 NOT NULL,
    "staerke_prozent" integer DEFAULT 75 NOT NULL,
    "vereinsschnitt" integer DEFAULT 500 NOT NULL,
    CONSTRAINT "rating_einstellungen_gewicht_check" CHECK (("gewicht" >= 0)),
    CONSTRAINT "rating_einstellungen_mindest_racks_check" CHECK (("mindest_racks" >= 0)),
    CONSTRAINT "rating_einstellungen_rueckgriff_monate_check" CHECK (("rueckgriff_monate" > 0)),
    CONSTRAINT "rating_einstellungen_staerke_prozent_check" CHECK ((("staerke_prozent" >= 0) AND ("staerke_prozent" <= 100))),
    CONSTRAINT "rating_einstellungen_vereinsschnitt_check" CHECK ((("vereinsschnitt" >= 100) AND ("vereinsschnitt" <= 1000))),
    CONSTRAINT "rating_einstellungen_zeitraum_monate_check" CHECK (("zeitraum_monate" > 0))
);


ALTER TABLE "public"."rating_einstellungen" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."turniere" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "datum" "date" NOT NULL,
    "disziplin" "public"."disziplin" DEFAULT '8-ball'::"public"."disziplin" NOT NULL,
    "modus" "public"."turnier_modus" DEFAULT 'einzelgruppe'::"public"."turnier_modus" NOT NULL,
    "serie_id" "uuid",
    "status" "public"."turnier_status" DEFAULT 'geplant'::"public"."turnier_status" NOT NULL,
    "rating_werten" boolean DEFAULT true NOT NULL,
    "eingefroren_am" timestamp with time zone,
    "einstellungen" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "quelle" "text" DEFAULT 'cuedesk'::"text" NOT NULL,
    "alt_id" "text",
    "importiert_am" timestamp with time zone,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "teilnehmerzahl" integer,
    CONSTRAINT "turniere_teilnehmerzahl_check" CHECK (("teilnehmerzahl" >= 0))
);


ALTER TABLE "public"."turniere" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."rating_partien" WITH ("security_invoker"='true') AS
 SELECT "p"."id",
    "p"."verein_id",
    "p"."turnier_id",
    "p"."disziplin",
    "p"."datum",
    "p"."spieler_a",
    "p"."spieler_b",
    GREATEST((COALESCE("p"."ergebnis_a", 0) - "p"."vorgabe_a"), 0) AS "racks_a",
    GREATEST((COALESCE("p"."ergebnis_b", 0) - "p"."vorgabe_b"), 0) AS "racks_b"
   FROM ((("public"."partien" "p"
     JOIN "public"."turniere" "t" ON (("t"."id" = "p"."turnier_id")))
     JOIN "public"."personen" "a" ON (("a"."id" = "p"."spieler_a")))
     JOIN "public"."personen" "b" ON (("b"."id" = "p"."spieler_b")))
  WHERE (("p"."status" = 'beendet'::"public"."partie_status") AND "p"."rating_werten" AND "t"."rating_werten" AND ("p"."disziplin" <> '14-1'::"public"."disziplin") AND (("t"."modus" = 'liga'::"public"."turnier_modus") OR (("a"."status" <> 'gast'::"public"."personen_status") AND ("b"."status" <> 'gast'::"public"."personen_status"))));


ALTER VIEW "public"."rating_partien" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."rating_stand" (
    "verein_id" "uuid" NOT NULL,
    "stichtag" "date" NOT NULL,
    "disziplin" "text" NOT NULL,
    "person_id" "uuid" NOT NULL,
    "wert" integer NOT NULL,
    "racks" integer DEFAULT 0 NOT NULL,
    "quelle" "public"."rating_quelle" DEFAULT 'eigene-daten'::"public"."rating_quelle" NOT NULL
);


ALTER TABLE "public"."rating_stand" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."serien" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "name" "text" NOT NULL,
    "saison" "text",
    "disziplin" "public"."disziplin" DEFAULT '8-ball'::"public"."disziplin" NOT NULL,
    "streicher" integer DEFAULT 0 NOT NULL,
    "bonus" integer DEFAULT 1 NOT NULL,
    "aktiv" boolean DEFAULT true NOT NULL,
    "alt_id" "text",
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "serien_bonus_check" CHECK (("bonus" >= 0)),
    CONSTRAINT "serien_streicher_check" CHECK (("streicher" >= 0))
);


ALTER TABLE "public"."serien" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."support_freigaben" (
    "id" bigint NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "bis" timestamp with time zone NOT NULL,
    "erteilt_von" "uuid",
    "erteilt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "beendet_am" timestamp with time zone
);


ALTER TABLE "public"."support_freigaben" OWNER TO "postgres";


ALTER TABLE "public"."support_freigaben" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."support_freigaben_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."system_ereignisse" (
    "id" bigint NOT NULL,
    "zeit" timestamp with time zone DEFAULT "now"() NOT NULL,
    "art" "text" NOT NULL,
    "erfolg" boolean NOT NULL,
    "groesse_bytes" bigint,
    "text" "text"
);


ALTER TABLE "public"."system_ereignisse" OWNER TO "postgres";


ALTER TABLE "public"."system_ereignisse" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."system_ereignisse_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."system_protokoll" (
    "id" bigint NOT NULL,
    "zeit" timestamp with time zone DEFAULT "now"() NOT NULL,
    "benutzer_id" "uuid",
    "aktion" "text" NOT NULL,
    "verein_id" "uuid",
    "details" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL
);


ALTER TABLE "public"."system_protokoll" OWNER TO "postgres";


ALTER TABLE "public"."system_protokoll" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."system_protokoll_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."tische" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "nummer" integer NOT NULL,
    "bezeichnung" "text",
    "aktiv" boolean DEFAULT true NOT NULL,
    CONSTRAINT "tische_nummer_check" CHECK (("nummer" > 0))
);


ALTER TABLE "public"."tische" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."turnier_teilnehmer" (
    "turnier_id" "uuid" NOT NULL,
    "person_id" "uuid" NOT NULL,
    "verein_id" "uuid" NOT NULL,
    "startnummer" integer,
    "gruppe" "text",
    "gesetzt" boolean DEFAULT false NOT NULL,
    "endplatz" integer,
    "rating_eingefroren" integer,
    "rating_quelle" "public"."rating_quelle"
);


ALTER TABLE "public"."turnier_teilnehmer" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."verein_schutzwort" (
    "verein_id" "uuid" NOT NULL,
    "wort" "text" NOT NULL,
    "geaendert_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "verein_schutzwort_wort_check" CHECK ((("length"("btrim"("wort")) >= 3) AND ("length"("btrim"("wort")) <= 40)))
);


ALTER TABLE "public"."verein_schutzwort" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."vereine" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "kurzname" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "logo_url" "text",
    "farbe" "text",
    "aktiv" boolean DEFAULT true NOT NULL,
    "erstellt_am" timestamp with time zone DEFAULT "now"() NOT NULL,
    "einstellungen" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "ist_test" boolean DEFAULT false NOT NULL,
    "gesperrt_am" timestamp with time zone,
    "sperrgrund" "text",
    "export_am" timestamp with time zone,
    "loeschen_ab" "date",
    CONSTRAINT "vereine_farbe_check" CHECK (("farbe" ~ '^#[0-9a-fA-F]{6}$'::"text")),
    CONSTRAINT "vereine_slug_check" CHECK (("slug" ~ '^[a-z0-9-]{2,30}$'::"text"))
);


ALTER TABLE "public"."vereine" OWNER TO "postgres";


ALTER TABLE ONLY "public"."aenderungen"
    ADD CONSTRAINT "aenderungen_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."aufnahmen_141"
    ADD CONSTRAINT "aufnahmen_141_partie_id_lfd_nr_key" UNIQUE ("partie_id", "lfd_nr");



ALTER TABLE ONLY "public"."aufnahmen_141"
    ADD CONSTRAINT "aufnahmen_141_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."benutzer_personen"
    ADD CONSTRAINT "benutzer_personen_person_id_key" UNIQUE ("person_id");



ALTER TABLE ONLY "public"."benutzer_personen"
    ADD CONSTRAINT "benutzer_personen_pkey" PRIMARY KEY ("benutzer_id", "verein_id");



ALTER TABLE ONLY "public"."benutzer"
    ADD CONSTRAINT "benutzer_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."benutzer_rechte"
    ADD CONSTRAINT "benutzer_rechte_pkey" PRIMARY KEY ("benutzer_id", "verein_id");



ALTER TABLE ONLY "public"."benutzer_rollen"
    ADD CONSTRAINT "benutzer_rollen_pkey" PRIMARY KEY ("benutzer_id", "verein_id", "rolle");



ALTER TABLE ONLY "public"."einladungen"
    ADD CONSTRAINT "einladungen_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."einladungen"
    ADD CONSTRAINT "einladungen_verein_id_email_key" UNIQUE ("verein_id", "email");



ALTER TABLE ONLY "public"."geraete"
    ADD CONSTRAINT "geraete_auth_id_key" UNIQUE ("auth_id");



ALTER TABLE ONLY "public"."geraete"
    ADD CONSTRAINT "geraete_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."kopplungen"
    ADD CONSTRAINT "kopplungen_auth_id_key" UNIQUE ("auth_id");



ALTER TABLE ONLY "public"."kopplungen"
    ADD CONSTRAINT "kopplungen_pkey" PRIMARY KEY ("code");



ALTER TABLE ONLY "public"."live_stand"
    ADD CONSTRAINT "live_stand_pkey" PRIMARY KEY ("tisch_id");



ALTER TABLE ONLY "public"."mannschaft_spieler"
    ADD CONSTRAINT "mannschaft_spieler_mannschaft_id_person_id_key" UNIQUE ("mannschaft_id", "person_id");



ALTER TABLE ONLY "public"."mannschaft_spieler"
    ADD CONSTRAINT "mannschaft_spieler_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."mannschaften"
    ADD CONSTRAINT "mannschaften_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."mannschaften"
    ADD CONSTRAINT "mannschaften_verein_id_id_key" UNIQUE ("verein_id", "id");



ALTER TABLE ONLY "public"."mannschaften"
    ADD CONSTRAINT "mannschaften_verein_id_saison_name_key" UNIQUE ("verein_id", "saison", "name");



ALTER TABLE ONLY "public"."partien_141"
    ADD CONSTRAINT "partien_141_pkey" PRIMARY KEY ("partie_id");



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."personen_intern"
    ADD CONSTRAINT "personen_intern_pkey" PRIMARY KEY ("person_id");



ALTER TABLE ONLY "public"."personen"
    ADD CONSTRAINT "personen_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."personen"
    ADD CONSTRAINT "personen_verein_id_id_key" UNIQUE ("verein_id", "id");



ALTER TABLE ONLY "public"."rating_einstellungen"
    ADD CONSTRAINT "rating_einstellungen_pkey" PRIMARY KEY ("verein_id");



ALTER TABLE ONLY "public"."rating_stand"
    ADD CONSTRAINT "rating_stand_pkey" PRIMARY KEY ("verein_id", "stichtag", "disziplin", "person_id");



ALTER TABLE ONLY "public"."serien"
    ADD CONSTRAINT "serien_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."serien"
    ADD CONSTRAINT "serien_verein_id_id_key" UNIQUE ("verein_id", "id");



ALTER TABLE ONLY "public"."support_freigaben"
    ADD CONSTRAINT "support_freigaben_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."system_ereignisse"
    ADD CONSTRAINT "system_ereignisse_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."system_protokoll"
    ADD CONSTRAINT "system_protokoll_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tische"
    ADD CONSTRAINT "tische_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tische"
    ADD CONSTRAINT "tische_verein_id_id_key" UNIQUE ("verein_id", "id");



ALTER TABLE ONLY "public"."tische"
    ADD CONSTRAINT "tische_verein_id_nummer_key" UNIQUE ("verein_id", "nummer");



ALTER TABLE ONLY "public"."turnier_teilnehmer"
    ADD CONSTRAINT "turnier_teilnehmer_pkey" PRIMARY KEY ("turnier_id", "person_id");



ALTER TABLE ONLY "public"."turniere"
    ADD CONSTRAINT "turniere_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."turniere"
    ADD CONSTRAINT "turniere_verein_id_id_key" UNIQUE ("verein_id", "id");



ALTER TABLE ONLY "public"."verein_schutzwort"
    ADD CONSTRAINT "verein_schutzwort_pkey" PRIMARY KEY ("verein_id");



ALTER TABLE ONLY "public"."vereine"
    ADD CONSTRAINT "vereine_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."vereine"
    ADD CONSTRAINT "vereine_slug_key" UNIQUE ("slug");



CREATE INDEX "aenderungen_verein_zeit" ON "public"."aenderungen" USING "btree" ("verein_id", "zeitpunkt" DESC);



CREATE INDEX "aufnahmen_141_spieler" ON "public"."aufnahmen_141" USING "btree" ("spieler");



CREATE INDEX "mannschaft_spieler_person" ON "public"."mannschaft_spieler" USING "btree" ("person_id");



CREATE INDEX "mannschaften_verein_saison" ON "public"."mannschaften" USING "btree" ("verein_id", "saison");



CREATE UNIQUE INDEX "partien_ko_einmal" ON "public"."partien" USING "btree" ("turnier_id", "gruppe") WHERE ("phase" = 'ko'::"text");



CREATE UNIQUE INDEX "partien_platzierung_einmal" ON "public"."partien" USING "btree" ("turnier_id", "phase", "paarung") WHERE ("phase" = ANY (ARRAY['phase2'::"text", 'phase3'::"text"]));



CREATE INDEX "partien_spieler_a" ON "public"."partien" USING "btree" ("spieler_a");



CREATE INDEX "partien_spieler_b" ON "public"."partien" USING "btree" ("spieler_b");



CREATE INDEX "partien_turnier" ON "public"."partien" USING "btree" ("turnier_id");



CREATE INDEX "partien_verein_datum" ON "public"."partien" USING "btree" ("verein_id", "datum" DESC);



CREATE UNIQUE INDEX "serien_alt_id" ON "public"."serien" USING "btree" ("verein_id", "alt_id") WHERE ("alt_id" IS NOT NULL);



CREATE UNIQUE INDEX "turniere_alt_id" ON "public"."turniere" USING "btree" ("verein_id", "alt_id") WHERE ("alt_id" IS NOT NULL);



CREATE UNIQUE INDEX "turniere_name_datum" ON "public"."turniere" USING "btree" ("verein_id", "name", "datum");



CREATE INDEX "turniere_verein_datum" ON "public"."turniere" USING "btree" ("verein_id", "datum" DESC);



CREATE OR REPLACE TRIGGER "admin_selbstsperre" BEFORE DELETE ON "public"."benutzer_rollen" FOR EACH ROW EXECUTE FUNCTION "public"."admin_selbstsperre"();



CREATE OR REPLACE TRIGGER "einladung_sofort" AFTER INSERT ON "public"."einladungen" FOR EACH ROW EXECUTE FUNCTION "public"."einladung_sofort"();



CREATE OR REPLACE TRIGGER "geaendert_am" BEFORE UPDATE ON "public"."mannschaften" FOR EACH ROW EXECUTE FUNCTION "public"."geaendert_am_setzen"();



CREATE OR REPLACE TRIGGER "geaendert_am" BEFORE UPDATE ON "public"."personen" FOR EACH ROW EXECUTE FUNCTION "public"."geaendert_am_setzen"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."benutzer_personen" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."benutzer_rechte" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."benutzer_rollen" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."einladungen" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."geraete" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."mannschaft_spieler" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."mannschaften" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."partien" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."partien_141" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."personen" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."personen_intern" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."serien" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."tische" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."turnier_teilnehmer" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."turniere" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "protokoll" AFTER INSERT OR DELETE OR UPDATE ON "public"."vereine" FOR EACH ROW EXECUTE FUNCTION "public"."aenderung_protokollieren"();



CREATE OR REPLACE TRIGGER "vereine_schutz" BEFORE UPDATE ON "public"."vereine" FOR EACH ROW EXECUTE FUNCTION "public"."vereine_schutz"();



ALTER TABLE ONLY "public"."aufnahmen_141"
    ADD CONSTRAINT "aufnahmen_141_partie_id_fkey" FOREIGN KEY ("partie_id") REFERENCES "public"."partien"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."aufnahmen_141"
    ADD CONSTRAINT "aufnahmen_141_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."aufnahmen_141"
    ADD CONSTRAINT "aufnahmen_141_verein_id_spieler_fkey" FOREIGN KEY ("verein_id", "spieler") REFERENCES "public"."personen"("verein_id", "id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."benutzer"
    ADD CONSTRAINT "benutzer_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."benutzer_personen"
    ADD CONSTRAINT "benutzer_personen_benutzer_id_fkey" FOREIGN KEY ("benutzer_id") REFERENCES "public"."benutzer"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."benutzer_personen"
    ADD CONSTRAINT "benutzer_personen_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."benutzer_rechte"
    ADD CONSTRAINT "benutzer_rechte_benutzer_id_fkey" FOREIGN KEY ("benutzer_id") REFERENCES "public"."benutzer"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."benutzer_rechte"
    ADD CONSTRAINT "benutzer_rechte_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."benutzer_rollen"
    ADD CONSTRAINT "benutzer_rollen_benutzer_id_fkey" FOREIGN KEY ("benutzer_id") REFERENCES "public"."benutzer"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."benutzer_rollen"
    ADD CONSTRAINT "benutzer_rollen_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."einladungen"
    ADD CONSTRAINT "einladungen_eingeladen_von_fkey" FOREIGN KEY ("eingeladen_von") REFERENCES "public"."benutzer"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."einladungen"
    ADD CONSTRAINT "einladungen_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."einladungen"
    ADD CONSTRAINT "einladungen_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE SET NULL ("person_id");



ALTER TABLE ONLY "public"."geraete"
    ADD CONSTRAINT "geraete_auth_id_fkey" FOREIGN KEY ("auth_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."geraete"
    ADD CONSTRAINT "geraete_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."geraete"
    ADD CONSTRAINT "geraete_verein_id_tisch_id_fkey" FOREIGN KEY ("verein_id", "tisch_id") REFERENCES "public"."tische"("verein_id", "id") ON DELETE SET NULL ("tisch_id");



ALTER TABLE ONLY "public"."kopplungen"
    ADD CONSTRAINT "kopplungen_auth_id_fkey" FOREIGN KEY ("auth_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."live_stand"
    ADD CONSTRAINT "live_stand_tisch_id_fkey" FOREIGN KEY ("tisch_id") REFERENCES "public"."tische"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."live_stand"
    ADD CONSTRAINT "live_stand_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."mannschaft_spieler"
    ADD CONSTRAINT "mannschaft_spieler_verein_id_mannschaft_id_fkey" FOREIGN KEY ("verein_id", "mannschaft_id") REFERENCES "public"."mannschaften"("verein_id", "id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."mannschaft_spieler"
    ADD CONSTRAINT "mannschaft_spieler_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."mannschaften"
    ADD CONSTRAINT "mannschaften_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."partien_141"
    ADD CONSTRAINT "partien_141_partie_id_fkey" FOREIGN KEY ("partie_id") REFERENCES "public"."partien"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."partien_141"
    ADD CONSTRAINT "partien_141_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_eingetragen_von_fkey" FOREIGN KEY ("eingetragen_von") REFERENCES "public"."benutzer"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_turnier_id_fkey" FOREIGN KEY ("turnier_id") REFERENCES "public"."turniere"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_verein_id_spieler_a_fkey" FOREIGN KEY ("verein_id", "spieler_a") REFERENCES "public"."personen"("verein_id", "id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_verein_id_spieler_b_fkey" FOREIGN KEY ("verein_id", "spieler_b") REFERENCES "public"."personen"("verein_id", "id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."partien"
    ADD CONSTRAINT "partien_verein_id_tisch_id_fkey" FOREIGN KEY ("verein_id", "tisch_id") REFERENCES "public"."tische"("verein_id", "id") ON DELETE SET NULL ("tisch_id");



ALTER TABLE ONLY "public"."personen_intern"
    ADD CONSTRAINT "personen_intern_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "public"."personen"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."personen_intern"
    ADD CONSTRAINT "personen_intern_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."personen"
    ADD CONSTRAINT "personen_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."rating_einstellungen"
    ADD CONSTRAINT "rating_einstellungen_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."rating_stand"
    ADD CONSTRAINT "rating_stand_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."rating_stand"
    ADD CONSTRAINT "rating_stand_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."serien"
    ADD CONSTRAINT "serien_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."support_freigaben"
    ADD CONSTRAINT "support_freigaben_erteilt_von_fkey" FOREIGN KEY ("erteilt_von") REFERENCES "public"."benutzer"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."support_freigaben"
    ADD CONSTRAINT "support_freigaben_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."system_protokoll"
    ADD CONSTRAINT "system_protokoll_benutzer_id_fkey" FOREIGN KEY ("benutzer_id") REFERENCES "public"."benutzer"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."system_protokoll"
    ADD CONSTRAINT "system_protokoll_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."tische"
    ADD CONSTRAINT "tische_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."turnier_teilnehmer"
    ADD CONSTRAINT "turnier_teilnehmer_turnier_id_fkey" FOREIGN KEY ("turnier_id") REFERENCES "public"."turniere"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."turnier_teilnehmer"
    ADD CONSTRAINT "turnier_teilnehmer_verein_id_person_id_fkey" FOREIGN KEY ("verein_id", "person_id") REFERENCES "public"."personen"("verein_id", "id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."turniere"
    ADD CONSTRAINT "turniere_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."turniere"
    ADD CONSTRAINT "turniere_verein_id_serie_id_fkey" FOREIGN KEY ("verein_id", "serie_id") REFERENCES "public"."serien"("verein_id", "id") ON DELETE SET NULL ("serie_id");



ALTER TABLE ONLY "public"."verein_schutzwort"
    ADD CONSTRAINT "verein_schutzwort_verein_id_fkey" FOREIGN KEY ("verein_id") REFERENCES "public"."vereine"("id") ON DELETE CASCADE;



CREATE POLICY "a141_lesen" ON "public"."aufnahmen_141" FOR SELECT TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id") OR (EXISTS ( SELECT 1
   FROM "public"."partien" "p"
  WHERE (("p"."id" = "aufnahmen_141"."partie_id") AND ("public"."ist_eigene_person"("p"."spieler_a") OR "public"."ist_eigene_person"("p"."spieler_b")))))));



CREATE POLICY "a141_schreiben" ON "public"."aufnahmen_141" TO "authenticated" USING ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]))) WITH CHECK ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[])));



ALTER TABLE "public"."aenderungen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "aenderungen_lesen" ON "public"."aenderungen" FOR SELECT TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id") OR (("tabelle" = ANY (ARRAY['partien'::"text", 'turniere'::"text", 'turnier_teilnehmer'::"text"])) AND "public"."hat_rolle"("verein_id", '{sportwart,turnierleiter}'::"public"."rolle"[]))));



ALTER TABLE "public"."aufnahmen_141" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."benutzer" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "benutzer_lesen" ON "public"."benutzer" FOR SELECT TO "authenticated" USING ((("id" = "auth"."uid"()) OR "public"."ist_systemadmin"() OR (EXISTS ( SELECT 1
   FROM "public"."benutzer_rollen" "r"
  WHERE (("r"."benutzer_id" = "benutzer"."id") AND "public"."hat_rolle"("r"."verein_id", '{vereinsadmin}'::"public"."rolle"[]))))));



ALTER TABLE "public"."benutzer_personen" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."benutzer_rechte" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."benutzer_rollen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "benutzer_selbst_aendern" ON "public"."benutzer" FOR UPDATE TO "authenticated" USING (("id" = "auth"."uid"())) WITH CHECK (("id" = "auth"."uid"()));



CREATE POLICY "bp_lesen" ON "public"."benutzer_personen" FOR SELECT TO "authenticated" USING ((("benutzer_id" = "auth"."uid"()) OR "public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "bp_schreiben" ON "public"."benutzer_personen" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]));



ALTER TABLE "public"."einladungen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "einladungen_aendern" ON "public"."einladungen" FOR UPDATE TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"())) WITH CHECK (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"()));



CREATE POLICY "einladungen_anlegen" ON "public"."einladungen" FOR INSERT TO "authenticated" WITH CHECK (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"() OR ("public"."darf_einladen"("verein_id") AND ("rollen" <@ '{mitglied}'::"public"."rolle"[]))));



CREATE POLICY "einladungen_lesen" ON "public"."einladungen" FOR SELECT TO "authenticated" USING (("public"."darf_einladen"("verein_id") OR "public"."ist_systemadmin"()));



CREATE POLICY "einladungen_loeschen" ON "public"."einladungen" FOR DELETE TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"() OR ("public"."darf_einladen"("verein_id") AND ("angenommen_am" IS NULL) AND ("rollen" <@ '{mitglied}'::"public"."rolle"[]))));



CREATE POLICY "ereignisse_lesen" ON "public"."system_ereignisse" FOR SELECT TO "authenticated" USING ("public"."ist_systemadmin"());



CREATE POLICY "freigaben_lesen" ON "public"."support_freigaben" FOR SELECT TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"()));



ALTER TABLE "public"."geraete" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "geraete_aendern" ON "public"."geraete" FOR UPDATE TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,turnierleiter}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,turnierleiter}'::"public"."rolle"[]));



CREATE POLICY "geraete_lesen" ON "public"."geraete" FOR SELECT TO "authenticated" USING ((("auth_id" = "auth"."uid"()) OR "public"."hat_rolle"("verein_id", '{vereinsadmin,turnierleiter}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "geraete_loeschen" ON "public"."geraete" FOR DELETE TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]));



ALTER TABLE "public"."kopplungen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "live_lesen" ON "public"."live_stand" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "live_schreiben" ON "public"."live_stand" TO "authenticated" USING ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]))) WITH CHECK ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[])));



ALTER TABLE "public"."live_stand" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."mannschaft_spieler" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "mannschaft_spieler_lesen" ON "public"."mannschaft_spieler" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "mannschaft_spieler_schreiben" ON "public"."mannschaft_spieler" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



ALTER TABLE "public"."mannschaften" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "mannschaften_lesen" ON "public"."mannschaften" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "mannschaften_schreiben" ON "public"."mannschaften" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



CREATE POLICY "p141_lesen" ON "public"."partien_141" FOR SELECT TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id") OR (EXISTS ( SELECT 1
   FROM "public"."partien" "p"
  WHERE (("p"."id" = "partien_141"."partie_id") AND ("public"."ist_eigene_person"("p"."spieler_a") OR "public"."ist_eigene_person"("p"."spieler_b")))))));



CREATE POLICY "p141_schreiben" ON "public"."partien_141" TO "authenticated" USING ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]))) WITH CHECK ((("public"."geraet_verein"() = "verein_id") OR "public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[])));



ALTER TABLE "public"."partien" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."partien_141" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "partien_lesen" ON "public"."partien" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "partien_schreiben" ON "public"."partien" TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]) OR ("public"."geraet_verein"() = "verein_id"))) WITH CHECK (("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]) OR ("public"."geraet_verein"() = "verein_id")));



ALTER TABLE "public"."personen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "personen_anlegen" ON "public"."personen" FOR INSERT TO "authenticated" WITH CHECK ("public"."darf_einladen"("verein_id"));



CREATE POLICY "personen_gast_am_tablet" ON "public"."personen" FOR INSERT TO "authenticated" WITH CHECK ((("public"."geraet_verein"() = "verein_id") AND ("status" = 'gast'::"public"."personen_status")));



CREATE POLICY "personen_gast_turnierleitung" ON "public"."personen" FOR INSERT TO "authenticated" WITH CHECK ((("status" = 'gast'::"public"."personen_status") AND "public"."hat_rolle"("verein_id", '{turnierleiter}'::"public"."rolle"[])));



ALTER TABLE "public"."personen_intern" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "personen_lesen" ON "public"."personen" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "personen_schreiben" ON "public"."personen" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



CREATE POLICY "pi_lesen" ON "public"."personen_intern" FOR SELECT TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "pi_schreiben" ON "public"."personen_intern" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



CREATE POLICY "protokoll_lesen" ON "public"."system_protokoll" FOR SELECT TO "authenticated" USING ("public"."ist_systemadmin"());



ALTER TABLE "public"."rating_einstellungen" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "rating_einstellungen_lesen" ON "public"."rating_einstellungen" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "rating_einstellungen_schreiben" ON "public"."rating_einstellungen" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



ALTER TABLE "public"."rating_stand" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "rating_stand_lesen" ON "public"."rating_stand" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "rechte_lesen" ON "public"."benutzer_rechte" FOR SELECT TO "authenticated" USING ((("benutzer_id" = "auth"."uid"()) OR "public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "rechte_schreiben" ON "public"."benutzer_rechte" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]));



CREATE POLICY "rollen_lesen" ON "public"."benutzer_rollen" FOR SELECT TO "authenticated" USING ((("benutzer_id" = "auth"."uid"()) OR "public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"()));



CREATE POLICY "rollen_schreiben" ON "public"."benutzer_rollen" TO "authenticated" USING (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"())) WITH CHECK (("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]) OR "public"."ist_systemadmin"()));



ALTER TABLE "public"."serien" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "serien_lesen" ON "public"."serien" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "serien_schreiben" ON "public"."serien" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart}'::"public"."rolle"[]));



ALTER TABLE "public"."support_freigaben" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."system_ereignisse" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."system_protokoll" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "teilnehmer_lesen" ON "public"."turnier_teilnehmer" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "teilnehmer_schreiben" ON "public"."turnier_teilnehmer" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]));



ALTER TABLE "public"."tische" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "tische_lesen" ON "public"."tische" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "tische_schreiben" ON "public"."tische" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin}'::"public"."rolle"[]));



ALTER TABLE "public"."turnier_teilnehmer" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."turniere" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "turniere_lesen" ON "public"."turniere" FOR SELECT TO "authenticated" USING (("public"."ist_im_verein"("verein_id") OR "public"."support_freigegeben"("verein_id")));



CREATE POLICY "turniere_schreiben" ON "public"."turniere" TO "authenticated" USING ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[])) WITH CHECK ("public"."hat_rolle"("verein_id", '{vereinsadmin,sportwart,turnierleiter}'::"public"."rolle"[]));



ALTER TABLE "public"."verein_schutzwort" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."vereine" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "vereine_aendern" ON "public"."vereine" FOR UPDATE TO "authenticated" USING (("public"."ist_systemadmin"() OR "public"."hat_rolle"("id", '{vereinsadmin}'::"public"."rolle"[]))) WITH CHECK (("public"."ist_systemadmin"() OR "public"."hat_rolle"("id", '{vereinsadmin}'::"public"."rolle"[])));



CREATE POLICY "vereine_anlegen" ON "public"."vereine" FOR INSERT TO "authenticated" WITH CHECK ("public"."ist_systemadmin"());



CREATE POLICY "vereine_lesen" ON "public"."vereine" FOR SELECT TO "authenticated", "anon" USING (("aktiv" OR "public"."ist_systemadmin"()));



CREATE POLICY "vereine_loeschen" ON "public"."vereine" FOR DELETE TO "authenticated" USING ("public"."ist_systemadmin"());





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."live_stand";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."partien";



ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."turniere";









GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";











































































































































































REVOKE ALL ON FUNCTION "public"."admin_selbstsperre"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."admin_selbstsperre"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."aenderung_protokollieren"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."aenderung_protokollieren"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."anmeldung_mitschreiben"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."anmeldung_mitschreiben"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."aufraeumen"("p_arten" "text"[]) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."aufraeumen"("p_arten" "text"[]) TO "service_role";
GRANT ALL ON FUNCTION "public"."aufraeumen"("p_arten" "text"[]) TO "authenticated";



REVOKE ALL ON FUNCTION "public"."aufraeumen_intern"("p_ausfuehren" boolean, "p_arten" "text"[]) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."aufraeumen_intern"("p_ausfuehren" boolean, "p_arten" "text"[]) TO "service_role";



REVOKE ALL ON FUNCTION "public"."aufraeumen_vorschau"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."aufraeumen_vorschau"() TO "service_role";
GRANT ALL ON FUNCTION "public"."aufraeumen_vorschau"() TO "authenticated";



REVOKE ALL ON FUNCTION "public"."darf_einladen"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."darf_einladen"("p_verein" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."darf_einladen"("p_verein" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."demo_zuruecksetzen"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."demo_zuruecksetzen"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."demo_zuruecksetzen"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."einladung_sofort"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."einladung_sofort"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."einladungen_uebernehmen"("p_benutzer" "uuid", "p_email" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."einladungen_uebernehmen"("p_benutzer" "uuid", "p_email" "text") TO "service_role";



REVOKE ALL ON FUNCTION "public"."geaendert_am_setzen"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geaendert_am_setzen"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."geraet_koppeln"("p_code" "text", "p_verein" "uuid", "p_name" "text", "p_tisch" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geraet_koppeln"("p_code" "text", "p_verein" "uuid", "p_name" "text", "p_tisch" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geraet_koppeln"("p_code" "text", "p_verein" "uuid", "p_name" "text", "p_tisch" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."geraet_meldet_sich"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geraet_meldet_sich"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."geraet_meldet_sich"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."geraet_neu_geladen"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geraet_neu_geladen"() TO "service_role";
GRANT ALL ON FUNCTION "public"."geraet_neu_geladen"() TO "authenticated";



REVOKE ALL ON FUNCTION "public"."geraet_tisch_setzen"("p_tisch" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geraet_tisch_setzen"("p_tisch" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."geraet_tisch_setzen"("p_tisch" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."geraet_verein"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."geraet_verein"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."geraet_verein"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."hat_rolle"("p_verein" "uuid", "p_rollen" "public"."rolle"[]) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."hat_rolle"("p_verein" "uuid", "p_rollen" "public"."rolle"[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."hat_rolle"("p_verein" "uuid", "p_rollen" "public"."rolle"[]) TO "service_role";



REVOKE ALL ON FUNCTION "public"."ist_eigene_person"("p_person" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."ist_eigene_person"("p_person" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."ist_eigene_person"("p_person" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."ist_im_verein"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."ist_im_verein"("p_verein" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."ist_im_verein"("p_verein" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."ist_systemadmin"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."ist_systemadmin"() TO "anon";
GRANT ALL ON FUNCTION "public"."ist_systemadmin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."ist_systemadmin"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."konsole_datenbank"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."konsole_datenbank"() TO "service_role";
GRANT ALL ON FUNCTION "public"."konsole_datenbank"() TO "authenticated";



REVOKE ALL ON FUNCTION "public"."konsole_vereine"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."konsole_vereine"() TO "service_role";
GRANT ALL ON FUNCTION "public"."konsole_vereine"() TO "authenticated";



REVOKE ALL ON FUNCTION "public"."kopplung_anfordern"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."kopplung_anfordern"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."kopplung_anfordern"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."meine_vereine"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."meine_vereine"() TO "service_role";
GRANT ALL ON FUNCTION "public"."meine_vereine"() TO "authenticated";



REVOKE ALL ON FUNCTION "public"."neues_konto"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."neues_konto"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."protokollieren"("p_aktion" "text", "p_verein" "uuid", "p_details" "jsonb") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."protokollieren"("p_aktion" "text", "p_verein" "uuid", "p_details" "jsonb") TO "service_role";



REVOKE ALL ON FUNCTION "public"."rating_nachts"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."rating_nachts"() TO "service_role";



GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."schutzwort_setzen"("p_verein" "uuid", "p_wort" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."schutzwort_setzen"("p_verein" "uuid", "p_wort" "text") TO "service_role";
GRANT ALL ON FUNCTION "public"."schutzwort_setzen"("p_verein" "uuid", "p_wort" "text") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."schutzwort_stimmt"("p_verein" "uuid", "p_wort" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."schutzwort_stimmt"("p_verein" "uuid", "p_wort" "text") TO "service_role";
GRANT ALL ON FUNCTION "public"."schutzwort_stimmt"("p_verein" "uuid", "p_wort" "text") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."support_beenden"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."support_beenden"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."support_beenden"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."support_freigeben"("p_verein" "uuid", "p_tage" integer) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."support_freigeben"("p_verein" "uuid", "p_tage" integer) TO "service_role";
GRANT ALL ON FUNCTION "public"."support_freigeben"("p_verein" "uuid", "p_tage" integer) TO "authenticated";



REVOKE ALL ON FUNCTION "public"."support_freigegeben"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."support_freigegeben"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."support_freigegeben"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."systemadmin_setzen"("p_email" "text", "p_ja" boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."systemadmin_setzen"("p_email" "text", "p_ja" boolean) TO "service_role";
GRANT ALL ON FUNCTION "public"."systemadmin_setzen"("p_email" "text", "p_ja" boolean) TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_anlegen"("p_name" "text", "p_kurzname" "text", "p_slug" "text", "p_test" boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_anlegen"("p_name" "text", "p_kurzname" "text", "p_slug" "text", "p_test" boolean) TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_anlegen"("p_name" "text", "p_kurzname" "text", "p_slug" "text", "p_test" boolean) TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_endgueltig_loeschen"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_endgueltig_loeschen"("p_verein" "uuid") TO "service_role";



REVOKE ALL ON FUNCTION "public"."verein_entsperren"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_entsperren"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_entsperren"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_export"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_export"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_export"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_loeschen_abbrechen"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_loeschen_abbrechen"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_loeschen_abbrechen"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_loeschen_vormerken"("p_verein" "uuid") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_loeschen_vormerken"("p_verein" "uuid") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_loeschen_vormerken"("p_verein" "uuid") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_sofort_loeschen"("p_verein" "uuid", "p_name" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_sofort_loeschen"("p_verein" "uuid", "p_name" "text") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_sofort_loeschen"("p_verein" "uuid", "p_name" "text") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."verein_sperren"("p_verein" "uuid", "p_grund" "text") FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."verein_sperren"("p_verein" "uuid", "p_grund" "text") TO "service_role";
GRANT ALL ON FUNCTION "public"."verein_sperren"("p_verein" "uuid", "p_grund" "text") TO "authenticated";



REVOKE ALL ON FUNCTION "public"."vereine_loeschen_faellig"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."vereine_loeschen_faellig"() TO "service_role";



REVOKE ALL ON FUNCTION "public"."vereine_schutz"() FROM PUBLIC;
GRANT ALL ON FUNCTION "public"."vereine_schutz"() TO "service_role";
























GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."aenderungen" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."aenderungen" TO "authenticated";
GRANT ALL ON TABLE "public"."aenderungen" TO "service_role";



GRANT ALL ON SEQUENCE "public"."aenderungen_id_seq" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."aufnahmen_141" TO "anon";
GRANT ALL ON TABLE "public"."aufnahmen_141" TO "authenticated";
GRANT ALL ON TABLE "public"."aufnahmen_141" TO "service_role";



GRANT ALL ON SEQUENCE "public"."aufnahmen_141_id_seq" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."benutzer" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."benutzer" TO "authenticated";
GRANT ALL ON TABLE "public"."benutzer" TO "service_role";



GRANT UPDATE("anzeigename") ON TABLE "public"."benutzer" TO "authenticated";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."benutzer_personen" TO "anon";
GRANT ALL ON TABLE "public"."benutzer_personen" TO "authenticated";
GRANT ALL ON TABLE "public"."benutzer_personen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."benutzer_rechte" TO "anon";
GRANT ALL ON TABLE "public"."benutzer_rechte" TO "authenticated";
GRANT ALL ON TABLE "public"."benutzer_rechte" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."benutzer_rollen" TO "anon";
GRANT ALL ON TABLE "public"."benutzer_rollen" TO "authenticated";
GRANT ALL ON TABLE "public"."benutzer_rollen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."einladungen" TO "anon";
GRANT ALL ON TABLE "public"."einladungen" TO "authenticated";
GRANT ALL ON TABLE "public"."einladungen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."geraete" TO "anon";
GRANT SELECT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "public"."geraete" TO "authenticated";
GRANT ALL ON TABLE "public"."geraete" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."kopplungen" TO "anon";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."kopplungen" TO "authenticated";
GRANT ALL ON TABLE "public"."kopplungen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."live_stand" TO "anon";
GRANT ALL ON TABLE "public"."live_stand" TO "authenticated";
GRANT ALL ON TABLE "public"."live_stand" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."mannschaft_spieler" TO "anon";
GRANT ALL ON TABLE "public"."mannschaft_spieler" TO "authenticated";
GRANT ALL ON TABLE "public"."mannschaft_spieler" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."mannschaften" TO "anon";
GRANT ALL ON TABLE "public"."mannschaften" TO "authenticated";
GRANT ALL ON TABLE "public"."mannschaften" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."partien" TO "anon";
GRANT ALL ON TABLE "public"."partien" TO "authenticated";
GRANT ALL ON TABLE "public"."partien" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."partien_141" TO "anon";
GRANT ALL ON TABLE "public"."partien_141" TO "authenticated";
GRANT ALL ON TABLE "public"."partien_141" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."personen" TO "anon";
GRANT ALL ON TABLE "public"."personen" TO "authenticated";
GRANT ALL ON TABLE "public"."personen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."personen_intern" TO "anon";
GRANT ALL ON TABLE "public"."personen_intern" TO "authenticated";
GRANT ALL ON TABLE "public"."personen_intern" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rating_einstellungen" TO "anon";
GRANT ALL ON TABLE "public"."rating_einstellungen" TO "authenticated";
GRANT ALL ON TABLE "public"."rating_einstellungen" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."turniere" TO "anon";
GRANT ALL ON TABLE "public"."turniere" TO "authenticated";
GRANT ALL ON TABLE "public"."turniere" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rating_partien" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rating_partien" TO "authenticated";
GRANT ALL ON TABLE "public"."rating_partien" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rating_stand" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."rating_stand" TO "authenticated";
GRANT ALL ON TABLE "public"."rating_stand" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."serien" TO "anon";
GRANT ALL ON TABLE "public"."serien" TO "authenticated";
GRANT ALL ON TABLE "public"."serien" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."support_freigaben" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."support_freigaben" TO "authenticated";
GRANT ALL ON TABLE "public"."support_freigaben" TO "service_role";



GRANT ALL ON SEQUENCE "public"."support_freigaben_id_seq" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."system_ereignisse" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."system_ereignisse" TO "authenticated";
GRANT ALL ON TABLE "public"."system_ereignisse" TO "service_role";



GRANT ALL ON SEQUENCE "public"."system_ereignisse_id_seq" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."system_protokoll" TO "anon";
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."system_protokoll" TO "authenticated";
GRANT ALL ON TABLE "public"."system_protokoll" TO "service_role";



GRANT ALL ON SEQUENCE "public"."system_protokoll_id_seq" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."tische" TO "anon";
GRANT ALL ON TABLE "public"."tische" TO "authenticated";
GRANT ALL ON TABLE "public"."tische" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."turnier_teilnehmer" TO "anon";
GRANT ALL ON TABLE "public"."turnier_teilnehmer" TO "authenticated";
GRANT ALL ON TABLE "public"."turnier_teilnehmer" TO "service_role";



GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."verein_schutzwort" TO "anon";
GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."verein_schutzwort" TO "authenticated";
GRANT ALL ON TABLE "public"."verein_schutzwort" TO "service_role";



GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE "public"."vereine" TO "anon";
GRANT ALL ON TABLE "public"."vereine" TO "authenticated";
GRANT ALL ON TABLE "public"."vereine" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";



































