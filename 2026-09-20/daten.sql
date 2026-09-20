SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict ZZvfr0gaOgYe7MGsQYOML3ew8R2ciN6FyJXH19XUjVcM0M4VynI0jy3e0N8CqLW

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'authenticated', 'authenticated', 'matthias.haas@errive.de', '$2a$10$R7ecmx9qDyKz1RIBgKQz8eIBqLwyN.xJISVjUi.JgwB61gNk6cfAi', '2026-09-20 08:08:20.434908+00', NULL, '', NULL, '', '2026-09-20 08:49:42.889998+00', '', '', NULL, '2026-09-20 08:50:26.711994+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-09-20 08:08:20.409891+00', '2026-09-20 13:59:23.496228+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 10:36:31.46633+00', '{}', '{}', NULL, '2026-09-20 10:36:31.445442+00', '2026-09-20 14:29:30.452424+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'authenticated', 'authenticated', 'luett.matten.de.haas@gmail.com', '', NULL, '2026-09-20 10:04:57.74149+00', 'ca06462d3805036336cc7cf1f68130a228b098c05eea252ad3dcf0a4', '2026-09-20 10:04:57.74149+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2026-09-20 10:04:57.703692+00', '2026-09-20 10:04:58.466765+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 11:07:57.257874+00', '{}', '{}', NULL, '2026-09-20 11:07:57.238233+00', '2026-09-20 11:07:57.280412+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '{"sub": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29", "email": "matthias.haas@errive.de", "email_verified": false, "phone_verified": false}', 'email', '2026-09-20 08:08:20.427938+00', '2026-09-20 08:08:20.428007+00', '2026-09-20 08:08:20.428007+00', '45171546-3e2b-4c0b-b12b-d20b2cb03d5b'),
	('0d2426bd-4c99-4746-b5c7-541412a1c778', '0d2426bd-4c99-4746-b5c7-541412a1c778', '{"sub": "0d2426bd-4c99-4746-b5c7-541412a1c778", "email": "luett.matten.de.haas@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2026-09-20 10:04:57.73587+00', '2026-09-20 10:04:57.735936+00', '2026-09-20 10:04:57.735936+00', '27c132f4-3bad-4744-84f9-bdfecb416e47');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") VALUES
	('1e8f732c-66c0-45a2-a445-599865ee3b65', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 08:44:49.238068+00', '2026-09-20 08:44:49.238068+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:156.0) Gecko/20100101 Firefox/156.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', '2026-09-20 11:07:57.259978+00', '2026-09-20 11:07:57.259978+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('ee3e204a-19f5-44fa-87b5-37f8b692c50b', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 08:50:26.714479+00', '2026-09-20 13:59:23.52822+00', NULL, 'aal1', NULL, '2026-09-20 13:59:23.528107', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('08f6a44e-e74d-49ce-b522-4d3515541e3b', '3c72b41b-9435-4c18-8048-bdb4e64bc719', '2026-09-20 10:36:31.467068+00', '2026-09-20 14:29:30.486003+00', NULL, 'aal1', NULL, '2026-09-20 14:29:30.485889', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/2.2553.1 Chrome/152.0.7977.76 Safari/537.36 MSIX', '84.171.246.34', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('1e8f732c-66c0-45a2-a445-599865ee3b65', '2026-09-20 08:44:49.256895+00', '2026-09-20 08:44:49.256895+00', 'otp', 'c58de688-bec7-4b20-81c4-55d89aa7076d'),
	('ee3e204a-19f5-44fa-87b5-37f8b692c50b', '2026-09-20 08:50:26.721126+00', '2026-09-20 08:50:26.721126+00', 'otp', 'f265f3ff-5541-4f69-8dde-ebb5af28f2fa'),
	('08f6a44e-e74d-49ce-b522-4d3515541e3b', '2026-09-20 10:36:31.488835+00', '2026-09-20 10:36:31.488835+00', 'anonymous', '1775f0a1-710d-4b7a-8ca5-268c0e29916c'),
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', '2026-09-20 11:07:57.282472+00', '2026-09-20 11:07:57.282472+00', 'anonymous', '26d0c58b-ba39-4267-b2f2-edfc25bae7db');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_code_sets; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_recovery_codes; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at", "expires_at") VALUES
	('a0f9bab0-aa4e-43a2-8a66-f83afbb8ad67', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'confirmation_token', 'ca06462d3805036336cc7cf1f68130a228b098c05eea252ad3dcf0a4', 'luett.matten.de.haas@gmail.com', '2026-09-20 10:04:58.472794', '2026-09-20 10:04:58.472794', NULL);


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 1, 'k7emiz3rjrb3', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 08:44:49.247259+00', '2026-09-20 08:44:49.247259+00', NULL, '1e8f732c-66c0-45a2-a445-599865ee3b65'),
	('00000000-0000-0000-0000-000000000000', 2, '6f3s5lfseicl', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 08:50:26.716955+00', '2026-09-20 09:48:34.6911+00', NULL, 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 3, '6qjxy5ygme33', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 09:48:34.704959+00', '2026-09-20 10:46:51.860858+00', '6f3s5lfseicl', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 6, '2h6r2rli2rvs', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', false, '2026-09-20 11:07:57.265795+00', '2026-09-20 11:07:57.265795+00', NULL, 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 4, 'qs2j3kyirjmo', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 10:36:31.474737+00', '2026-09-20 11:34:36.059891+00', NULL, '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 5, 'taez7xfxilxs', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 10:46:51.866411+00', '2026-09-20 11:45:20.520499+00', '6qjxy5ygme33', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 7, '67uukfwg4euw', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 11:34:36.082785+00', '2026-09-20 12:32:41.652556+00', 'qs2j3kyirjmo', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 8, 'pkla3ha6gidn', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 11:45:20.539895+00', '2026-09-20 13:01:13.247924+00', 'taez7xfxilxs', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 9, 'v7fotxzsophl', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 12:32:41.679735+00', '2026-09-20 13:30:59.744672+00', '67uukfwg4euw', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 10, 'qgzm2qvp62lq', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 13:01:13.261355+00', '2026-09-20 13:59:23.454336+00', 'pkla3ha6gidn', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 12, '6afyumh5xv2u', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 13:59:23.474515+00', '2026-09-20 13:59:23.474515+00', 'qgzm2qvp62lq', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 11, 'ql57mqlraw2o', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 13:30:59.762227+00', '2026-09-20 14:29:30.412832+00', 'v7fotxzsophl', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 13, 's62jwjlydatv', '3c72b41b-9435-4c18-8048-bdb4e64bc719', false, '2026-09-20 14:29:30.429381+00', '2026-09-20 14:29:30.429381+00', 'ql57mqlraw2o', '08f6a44e-e74d-49ce-b522-4d3515541e3b');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: scim_users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: aenderungen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."aenderungen" ("id", "zeitpunkt", "benutzer_id", "verein_id", "tabelle", "datensatz_id", "aktion", "vorher", "nachher") OVERRIDING SYSTEM VALUE VALUES
	(1, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'vereine', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'insert', NULL, '{"id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "name": "Billardverein Verden", "slug": "verden", "aktiv": true, "farbe": null, "kurzname": "Verden", "logo_url": null, "erstellt_am": "2026-09-20T08:09:22.644854+00:00"}'),
	(2, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'personen', '1ae18201-ba5d-4606-8d36-5f086cd76859', 'insert', NULL, '{"id": "1ae18201-ba5d-4606-8d36-5f086cd76859", "status": "mitglied", "kuerzel": "MH", "vorname": "Matthias", "nachname": "Haas", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "anzeigename": "Matthias", "erstellt_am": "2026-09-20T08:09:22.644854+00:00", "geaendert_am": "2026-09-20T08:09:22.644854+00:00", "name_oeffentlich": false}'),
	(3, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_personen', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'insert', NULL, '{"person_id": "1ae18201-ba5d-4606-8d36-5f086cd76859", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29"}'),
	(4, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_rollen', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'insert', NULL, '{"rolle": "vereinsadmin", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29"}'),
	(5, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_rollen', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'insert', NULL, '{"rolle": "sportwart", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29"}'),
	(6, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_rollen', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'insert', NULL, '{"rolle": "turnierleiter", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29"}'),
	(7, '2026-09-20 08:09:22.644854+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_rollen', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'insert', NULL, '{"rolle": "mitglied", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29"}'),
	(8, '2026-09-20 08:56:08.130107+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'personen', 'c02273d2-7569-4051-b3fe-7ba1138d4ae9', 'insert', NULL, '{"id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "status": "gast", "kuerzel": "TTE", "vorname": "Tim", "nachname": "Tester", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "anzeigename": "Tim", "erstellt_am": "2026-09-20T08:56:08.130107+00:00", "geaendert_am": "2026-09-20T08:56:08.130107+00:00", "name_oeffentlich": false}'),
	(9, '2026-09-20 08:56:08.33695+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'personen_intern', NULL, 'insert', NULL, '{"notiz": "luett.matten.de.haas@gmail.com", "austritt": null, "eintritt": null, "person_id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "minderjaehrig": false, "rating_startwert": null}'),
	(10, '2026-09-20 08:58:18.022692+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'personen', '1ae18201-ba5d-4606-8d36-5f086cd76859', 'update', '{"id": "1ae18201-ba5d-4606-8d36-5f086cd76859", "status": "mitglied", "kuerzel": "MH", "vorname": "Matthias", "nachname": "Haas", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "anzeigename": "Matthias", "erstellt_am": "2026-09-20T08:09:22.644854+00:00", "geaendert_am": "2026-09-20T08:09:22.644854+00:00", "name_oeffentlich": false}', '{"id": "1ae18201-ba5d-4606-8d36-5f086cd76859", "status": "mitglied", "kuerzel": "MH", "vorname": "Matthias", "nachname": "Haas", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "anzeigename": "Matthias", "erstellt_am": "2026-09-20T08:09:22.644854+00:00", "geaendert_am": "2026-09-20T08:58:18.022692+00:00", "name_oeffentlich": false}'),
	(11, '2026-09-20 08:58:18.111478+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'personen_intern', NULL, 'insert', NULL, '{"notiz": null, "austritt": null, "eintritt": "2025-10-20", "person_id": "1ae18201-ba5d-4606-8d36-5f086cd76859", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "minderjaehrig": false, "rating_startwert": 475}'),
	(12, '2026-09-20 10:04:57.607232+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'einladungen', '7dcda43f-3c2a-4a96-9970-476dd431e98e', 'insert', NULL, '{"id": "7dcda43f-3c2a-4a96-9970-476dd431e98e", "email": "luett.matten.de.haas@gmail.com", "rollen": ["mitglied"], "person_id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:04:57.607232+00:00", "angenommen_am": null, "eingeladen_von": null}'),
	(13, '2026-09-20 10:04:57.702543+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_rollen', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'insert', NULL, '{"rolle": "mitglied", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "0d2426bd-4c99-4746-b5c7-541412a1c778"}'),
	(14, '2026-09-20 10:04:57.702543+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'benutzer_personen', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'insert', NULL, '{"person_id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "benutzer_id": "0d2426bd-4c99-4746-b5c7-541412a1c778"}'),
	(15, '2026-09-20 10:04:57.702543+00', NULL, 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'einladungen', '7dcda43f-3c2a-4a96-9970-476dd431e98e', 'update', '{"id": "7dcda43f-3c2a-4a96-9970-476dd431e98e", "email": "luett.matten.de.haas@gmail.com", "rollen": ["mitglied"], "person_id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:04:57.607232+00:00", "angenommen_am": null, "eingeladen_von": null}', '{"id": "7dcda43f-3c2a-4a96-9970-476dd431e98e", "email": "luett.matten.de.haas@gmail.com", "rollen": ["mitglied"], "person_id": "c02273d2-7569-4051-b3fe-7ba1138d4ae9", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:04:57.607232+00:00", "angenommen_am": "2026-09-20T10:04:57.702543+00:00", "eingeladen_von": null}'),
	(16, '2026-09-20 10:36:51.08808+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'insert', NULL, '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": null}'),
	(17, '2026-09-20 10:36:51.08808+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'tische', '44f1764c-17e7-4f41-ae2c-0001c86f9017', 'insert', NULL, '{"id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "aktiv": true, "nummer": 1, "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "bezeichnung": "Turniertisch"}'),
	(18, '2026-09-20 10:36:52.391777+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": null}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:36:52.391777+00:00"}'),
	(19, '2026-09-20 10:37:52.799728+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:36:52.391777+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:37:52.799728+00:00"}'),
	(20, '2026-09-20 10:38:53.304279+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:37:52.799728+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:38:53.304279+00:00"}'),
	(21, '2026-09-20 10:39:53.538633+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:38:53.304279+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:39:53.538633+00:00"}'),
	(22, '2026-09-20 10:40:53.778144+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:39:53.538633+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:40:53.778144+00:00"}'),
	(23, '2026-09-20 10:41:54.115448+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:40:53.778144+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:41:54.115448+00:00"}'),
	(24, '2026-09-20 10:42:54.910729+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:41:54.115448+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:42:54.910729+00:00"}'),
	(25, '2026-09-20 10:43:55.167728+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:42:54.910729+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:43:55.167728+00:00"}'),
	(26, '2026-09-20 10:44:55.780704+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:43:55.167728+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:44:55.780704+00:00"}'),
	(27, '2026-09-20 10:45:56.140468+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:44:55.780704+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:45:56.140468+00:00"}'),
	(28, '2026-09-20 10:46:56.466787+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:45:56.140468+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:46:56.466787+00:00"}'),
	(29, '2026-09-20 10:47:56.865586+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:46:56.466787+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:47:56.865586+00:00"}'),
	(30, '2026-09-20 10:48:57.149618+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:47:56.865586+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:48:57.149618+00:00"}'),
	(31, '2026-09-20 10:49:57.388162+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:48:57.149618+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:49:57.388162+00:00"}'),
	(32, '2026-09-20 10:50:57.653942+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:49:57.388162+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:50:57.653942+00:00"}'),
	(33, '2026-09-20 10:51:57.885937+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:50:57.653942+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:51:57.885937+00:00"}'),
	(34, '2026-09-20 10:52:58.195961+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:51:57.885937+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:52:58.195961+00:00"}'),
	(35, '2026-09-20 10:53:58.336946+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:52:58.195961+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:53:58.336946+00:00"}'),
	(36, '2026-09-20 10:54:58.4831+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:53:58.336946+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:54:58.4831+00:00"}'),
	(37, '2026-09-20 10:55:58.931444+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:54:58.4831+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:55:58.931444+00:00"}'),
	(38, '2026-09-20 10:56:59.180655+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:55:58.931444+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:56:59.180655+00:00"}'),
	(39, '2026-09-20 10:57:59.418193+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:56:59.180655+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:57:59.418193+00:00"}'),
	(40, '2026-09-20 10:58:59.678737+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:57:59.418193+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:58:59.678737+00:00"}'),
	(41, '2026-09-20 10:59:59.920577+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:58:59.678737+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:59:59.920577+00:00"}'),
	(42, '2026-09-20 11:01:00.242013+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T10:59:59.920577+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:01:00.242013+00:00"}'),
	(43, '2026-09-20 11:02:00.803155+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:01:00.242013+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:02:00.803155+00:00"}'),
	(44, '2026-09-20 11:03:01.056336+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:02:00.803155+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:03:01.056336+00:00"}'),
	(45, '2026-09-20 11:04:01.297112+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:03:01.056336+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:04:01.297112+00:00"}'),
	(46, '2026-09-20 11:05:01.661184+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:04:01.297112+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:05:01.661184+00:00"}'),
	(47, '2026-09-20 11:06:01.988922+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:05:01.661184+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:06:01.988922+00:00"}'),
	(48, '2026-09-20 11:07:02.274833+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:06:01.988922+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:07:02.274833+00:00"}'),
	(49, '2026-09-20 11:08:02.449146+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:07:02.274833+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:08:02.449146+00:00"}'),
	(50, '2026-09-20 11:09:02.625807+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:08:02.449146+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:09:02.625807+00:00"}'),
	(51, '2026-09-20 11:10:02.791094+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:09:02.625807+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:10:02.791094+00:00"}'),
	(52, '2026-09-20 11:11:03.000209+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:10:02.791094+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:11:03.000209+00:00"}'),
	(53, '2026-09-20 11:12:03.208678+00', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'update', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:11:03.000209+00:00"}', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:12:03.208678+00:00"}'),
	(54, '2026-09-20 11:13:00.679157+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', 'b94ffdaa-9d32-4e33-822c-e85ff139c0c1', 'delete', '{"id": "b94ffdaa-9d32-4e33-822c-e85ff139c0c1", "name": "Testtablet", "aktiv": true, "auth_id": "3c72b41b-9435-4c18-8048-bdb4e64bc719", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T10:36:51.08808+00:00", "zuletzt_gesehen": "2026-09-20T11:12:03.208678+00:00"}', NULL),
	(55, '2026-09-20 11:14:12.50292+00', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'insert', NULL, '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": null}'),
	(56, '2026-09-20 11:14:13.495597+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": null}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:14:13.495597+00:00"}'),
	(57, '2026-09-20 11:15:13.857712+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:14:13.495597+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:15:13.857712+00:00"}'),
	(58, '2026-09-20 11:16:14.030307+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:15:13.857712+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:16:14.030307+00:00"}'),
	(59, '2026-09-20 11:17:14.163095+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:16:14.030307+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:17:14.163095+00:00"}'),
	(60, '2026-09-20 11:18:14.473512+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:17:14.163095+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:18:14.473512+00:00"}'),
	(61, '2026-09-20 11:19:14.684393+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:18:14.473512+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:19:14.684393+00:00"}'),
	(62, '2026-09-20 11:20:14.868937+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:19:14.684393+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:20:14.868937+00:00"}'),
	(63, '2026-09-20 11:21:15.975956+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:20:14.868937+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:21:15.975956+00:00"}'),
	(64, '2026-09-20 11:22:16.175385+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:21:15.975956+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:22:16.175385+00:00"}'),
	(65, '2026-09-20 11:23:16.377889+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:22:16.175385+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:23:16.377889+00:00"}'),
	(66, '2026-09-20 11:24:16.70947+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:23:16.377889+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:24:16.70947+00:00"}'),
	(67, '2026-09-20 11:25:16.717002+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:24:16.70947+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:25:16.717002+00:00"}'),
	(68, '2026-09-20 11:26:16.946656+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:25:16.717002+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:26:16.946656+00:00"}'),
	(69, '2026-09-20 11:27:17.107434+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:26:16.946656+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:27:17.107434+00:00"}'),
	(70, '2026-09-20 11:28:17.614027+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:27:17.107434+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:28:17.614027+00:00"}'),
	(71, '2026-09-20 11:29:17.708806+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:28:17.614027+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:29:17.708806+00:00"}'),
	(72, '2026-09-20 11:33:45.392631+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:29:17.708806+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:33:45.392631+00:00"}'),
	(73, '2026-09-20 11:34:45.670069+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:33:45.392631+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:34:45.670069+00:00"}'),
	(74, '2026-09-20 11:35:45.820724+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:34:45.670069+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:35:45.820724+00:00"}'),
	(75, '2026-09-20 11:36:46.038094+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:35:45.820724+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:36:46.038094+00:00"}'),
	(76, '2026-09-20 11:37:46.187993+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:36:46.038094+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:37:46.187993+00:00"}'),
	(77, '2026-09-20 11:38:46.48482+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:37:46.187993+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:38:46.48482+00:00"}'),
	(78, '2026-09-20 11:39:46.605053+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:38:46.48482+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:39:46.605053+00:00"}'),
	(79, '2026-09-20 11:40:46.774727+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:39:46.605053+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:40:46.774727+00:00"}'),
	(80, '2026-09-20 11:41:46.977773+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:40:46.774727+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:41:46.977773+00:00"}'),
	(81, '2026-09-20 11:42:47.239641+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:41:46.977773+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:42:47.239641+00:00"}'),
	(82, '2026-09-20 11:43:47.32609+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:42:47.239641+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:43:47.32609+00:00"}'),
	(83, '2026-09-20 11:44:48.522799+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:43:47.32609+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:44:48.522799+00:00"}'),
	(84, '2026-09-20 11:45:47.657134+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:44:48.522799+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:45:47.657134+00:00"}'),
	(85, '2026-09-20 11:46:47.812026+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:45:47.657134+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:46:47.812026+00:00"}'),
	(86, '2026-09-20 11:47:47.968076+00', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'geraete', '20f86adb-b440-4643-9df8-9c1843e45e86', 'update', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:46:47.812026+00:00"}', '{"id": "20f86adb-b440-4643-9df8-9c1843e45e86", "name": "Tablet Tisch 1", "aktiv": true, "auth_id": "d0bc23e3-7320-4c6a-a938-2f32e916d117", "tisch_id": "44f1764c-17e7-4f41-ae2c-0001c86f9017", "verein_id": "e932f2d9-0b53-4bde-a8d0-cd4bfd976df1", "erstellt_am": "2026-09-20T11:14:12.50292+00:00", "zuletzt_gesehen": "2026-09-20T11:47:47.968076+00:00"}');


--
-- Data for Name: benutzer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."benutzer" ("id", "email", "anzeigename", "systemadmin", "aktiv", "erstellt_am", "angemeldet_am") VALUES
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'matthias.haas@errive.de', 'Matthias', true, true, '2026-09-20 08:08:20.408629+00', '2026-09-20 08:50:26.711994+00'),
	('0d2426bd-4c99-4746-b5c7-541412a1c778', 'luett.matten.de.haas@gmail.com', NULL, false, true, '2026-09-20 10:04:57.702543+00', NULL);


--
-- Data for Name: vereine; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."vereine" ("id", "name", "kurzname", "slug", "logo_url", "farbe", "aktiv", "erstellt_am") VALUES
	('e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'Billardverein Verden', 'Verden', 'verden', NULL, NULL, true, '2026-09-20 08:09:22.644854+00');


--
-- Data for Name: personen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."personen" ("id", "verein_id", "vorname", "nachname", "anzeigename", "kuerzel", "status", "name_oeffentlich", "erstellt_am", "geaendert_am") VALUES
	('c02273d2-7569-4051-b3fe-7ba1138d4ae9', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'Tim', 'Tester', 'Tim', 'TTE', 'gast', false, '2026-09-20 08:56:08.130107+00', '2026-09-20 08:56:08.130107+00'),
	('1ae18201-ba5d-4606-8d36-5f086cd76859', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'Matthias', 'Haas', 'Matthias', 'MH', 'mitglied', false, '2026-09-20 08:09:22.644854+00', '2026-09-20 08:58:18.022692+00');


--
-- Data for Name: benutzer_personen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."benutzer_personen" ("benutzer_id", "verein_id", "person_id") VALUES
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', '1ae18201-ba5d-4606-8d36-5f086cd76859'),
	('0d2426bd-4c99-4746-b5c7-541412a1c778', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'c02273d2-7569-4051-b3fe-7ba1138d4ae9');


--
-- Data for Name: benutzer_rechte; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: benutzer_rollen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."benutzer_rollen" ("benutzer_id", "verein_id", "rolle") VALUES
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'vereinsadmin'),
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'sportwart'),
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'turnierleiter'),
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'mitglied'),
	('0d2426bd-4c99-4746-b5c7-541412a1c778', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'mitglied');


--
-- Data for Name: einladungen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."einladungen" ("id", "verein_id", "email", "rollen", "person_id", "eingeladen_von", "erstellt_am", "angenommen_am") VALUES
	('7dcda43f-3c2a-4a96-9970-476dd431e98e', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'luett.matten.de.haas@gmail.com', '{mitglied}', 'c02273d2-7569-4051-b3fe-7ba1138d4ae9', NULL, '2026-09-20 10:04:57.607232+00', '2026-09-20 10:04:57.702543+00');


--
-- Data for Name: tische; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."tische" ("id", "verein_id", "nummer", "bezeichnung", "aktiv") VALUES
	('44f1764c-17e7-4f41-ae2c-0001c86f9017', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 1, 'Turniertisch', true);


--
-- Data for Name: geraete; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."geraete" ("id", "verein_id", "auth_id", "name", "tisch_id", "aktiv", "zuletzt_gesehen", "erstellt_am") VALUES
	('20f86adb-b440-4643-9df8-9c1843e45e86', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'Tablet Tisch 1', '44f1764c-17e7-4f41-ae2c-0001c86f9017', true, '2026-09-20 11:47:47.968076+00', '2026-09-20 11:14:12.50292+00');


--
-- Data for Name: kopplungen; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."kopplungen" ("code", "auth_id", "erstellt_am") VALUES
	('YFBTVY', '3c72b41b-9435-4c18-8048-bdb4e64bc719', '2026-09-20 13:02:10.157889+00');


--
-- Data for Name: personen_intern; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."personen_intern" ("person_id", "verein_id", "eintritt", "austritt", "minderjaehrig", "rating_startwert", "notiz") VALUES
	('c02273d2-7569-4051-b3fe-7ba1138d4ae9', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', NULL, NULL, false, NULL, 'luett.matten.de.haas@gmail.com'),
	('1ae18201-ba5d-4606-8d36-5f086cd76859', 'e932f2d9-0b53-4bde-a8d0-cd4bfd976df1', '2025-10-20', NULL, false, 475, NULL);


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 13, true);


--
-- Name: aenderungen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."aenderungen_id_seq"', 86, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict ZZvfr0gaOgYe7MGsQYOML3ew8R2ciN6FyJXH19XUjVcM0M4VynI0jy3e0N8CqLW

RESET ALL;
