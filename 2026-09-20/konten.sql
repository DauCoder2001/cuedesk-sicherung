SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict rejmN4qg4qZbbEtLUUsQQ1ZqOCLpFIRF11MJryc0oHYateebyWSIybORAst8Hpg

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
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 13, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict rejmN4qg4qZbbEtLUUsQQ1ZqOCLpFIRF11MJryc0oHYateebyWSIybORAst8Hpg

RESET ALL;
