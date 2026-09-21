SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict J5A9uROoQGTUWjATofRshmrIGCOEYulY2ee9gg8qJ6odA8MKt0N1PM5SgZ01l7X

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
	('00000000-0000-0000-0000-000000000000', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 11:07:57.257874+00', '{}', '{}', NULL, '2026-09-20 11:07:57.238233+00', '2026-09-20 14:57:38.135193+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'authenticated', 'authenticated', 'luett.matten.de.haas@gmail.com', '', NULL, '2026-09-20 10:04:57.74149+00', 'ca06462d3805036336cc7cf1f68130a228b098c05eea252ad3dcf0a4', '2026-09-20 10:04:57.74149+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{}', NULL, '2026-09-20 10:04:57.703692+00', '2026-09-20 10:04:58.466765+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'd0e19909-c50f-40f6-a7c0-ac3d95d58979', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 14:58:56.944543+00', '{}', '{}', NULL, '2026-09-20 14:58:56.917136+00', '2026-09-20 14:58:56.960767+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 16:26:37.294994+00', '{}', '{}', NULL, '2026-09-20 16:26:37.269362+00', '2026-09-20 17:24:59.999642+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '89ed9f44-e323-445f-9301-898ea326f408', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 15:00:04.072401+00', '{}', '{}', NULL, '2026-09-20 15:00:04.069834+00', '2026-09-20 15:00:04.074693+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '81dc13f4-562e-4e26-9b86-c1f9fee30446', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 15:00:51.307227+00', '{}', '{}', NULL, '2026-09-20 15:00:51.280236+00', '2026-09-20 15:00:51.320641+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'authenticated', 'authenticated', 'matthias.haas@errive.de', '$2a$10$R7ecmx9qDyKz1RIBgKQz8eIBqLwyN.xJISVjUi.JgwB61gNk6cfAi', '2026-09-20 08:08:20.434908+00', NULL, '', NULL, '', '2026-09-20 16:20:00.143923+00', '', '', NULL, '2026-09-20 16:20:15.905895+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-09-20 08:08:20.409891+00', '2026-09-20 18:58:37.548284+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '3c72b41b-9435-4c18-8048-bdb4e64bc719', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 10:36:31.46633+00', '{}', '{}', NULL, '2026-09-20 10:36:31.445442+00', '2026-09-20 15:27:37.982052+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true);


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
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', '2026-09-20 11:07:57.259978+00', '2026-09-20 14:57:38.136513+00', NULL, 'aal1', NULL, '2026-09-20 14:57:38.136403', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('708230cf-ee0c-47a8-9224-3d35e4d9a651', 'd0e19909-c50f-40f6-a7c0-ac3d95d58979', '2026-09-20 14:58:56.945305+00', '2026-09-20 14:58:56.945305+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('5c66ea44-4116-4801-ad5c-a0710ab0fe82', '89ed9f44-e323-445f-9301-898ea326f408', '2026-09-20 15:00:04.072492+00', '2026-09-20 15:00:04.072492+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('3fdc0625-9d58-4629-9437-557c3aee5752', '81dc13f4-562e-4e26-9b86-c1f9fee30446', '2026-09-20 15:00:51.30872+00', '2026-09-20 15:00:51.30872+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/2.2553.1 Chrome/152.0.7977.76 Safari/537.36 MSIX', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('5206ac96-8674-4256-a49c-746ba780a987', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 15:07:09.173269+00', '2026-09-20 15:07:09.173269+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('bfd7408d-960d-43bc-9fe2-4f93d1ae2803', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 15:25:46.994602+00', '2026-09-20 15:25:46.994602+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:156.0) Gecko/20100101 Firefox/156.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('08f6a44e-e74d-49ce-b522-4d3515541e3b', '3c72b41b-9435-4c18-8048-bdb4e64bc719', '2026-09-20 10:36:31.467068+00', '2026-09-20 15:27:37.987022+00', NULL, 'aal1', NULL, '2026-09-20 15:27:37.986906', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/2.2553.1 Chrome/152.0.7977.76 Safari/537.36 MSIX', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('85a3e4db-23b9-4607-ad53-3b6257bb0af2', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', '2026-09-20 16:26:37.297024+00', '2026-09-20 17:25:00.019789+00', NULL, 'aal1', NULL, '2026-09-20 17:25:00.019667', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('c9d751fb-f3d2-49ad-8ebc-539562e3b9e2', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 16:20:15.906631+00', '2026-09-20 18:48:15.425989+00', NULL, 'aal1', NULL, '2026-09-20 18:48:15.425855', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL),
	('ee3e204a-19f5-44fa-87b5-37f8b692c50b', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-20 08:50:26.714479+00', '2026-09-20 18:58:37.572321+00', NULL, 'aal1', NULL, '2026-09-20 18:58:37.572158', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.246.34', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('1e8f732c-66c0-45a2-a445-599865ee3b65', '2026-09-20 08:44:49.256895+00', '2026-09-20 08:44:49.256895+00', 'otp', 'c58de688-bec7-4b20-81c4-55d89aa7076d'),
	('ee3e204a-19f5-44fa-87b5-37f8b692c50b', '2026-09-20 08:50:26.721126+00', '2026-09-20 08:50:26.721126+00', 'otp', 'f265f3ff-5541-4f69-8dde-ebb5af28f2fa'),
	('08f6a44e-e74d-49ce-b522-4d3515541e3b', '2026-09-20 10:36:31.488835+00', '2026-09-20 10:36:31.488835+00', 'anonymous', '1775f0a1-710d-4b7a-8ca5-268c0e29916c'),
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', '2026-09-20 11:07:57.282472+00', '2026-09-20 11:07:57.282472+00', 'anonymous', '26d0c58b-ba39-4267-b2f2-edfc25bae7db'),
	('708230cf-ee0c-47a8-9224-3d35e4d9a651', '2026-09-20 14:58:56.971335+00', '2026-09-20 14:58:56.971335+00', 'anonymous', 'b1e027bd-e6e0-43a2-a366-66cc4d689e7f'),
	('5c66ea44-4116-4801-ad5c-a0710ab0fe82', '2026-09-20 15:00:04.075152+00', '2026-09-20 15:00:04.075152+00', 'anonymous', '359d02e2-5a05-491d-b1c6-707c77e82c70'),
	('3fdc0625-9d58-4629-9437-557c3aee5752', '2026-09-20 15:00:51.322028+00', '2026-09-20 15:00:51.322028+00', 'anonymous', 'f1e5d756-aaf2-41e0-9140-81eb9a900079'),
	('5206ac96-8674-4256-a49c-746ba780a987', '2026-09-20 15:07:09.184651+00', '2026-09-20 15:07:09.184651+00', 'otp', '033425e9-ced4-4f18-9ef0-5befb5f2b735'),
	('bfd7408d-960d-43bc-9fe2-4f93d1ae2803', '2026-09-20 15:25:47.00478+00', '2026-09-20 15:25:47.00478+00', 'otp', 'fbb3b27c-3bf1-4953-abf5-9ffa22ea2937'),
	('c9d751fb-f3d2-49ad-8ebc-539562e3b9e2', '2026-09-20 16:20:15.942623+00', '2026-09-20 16:20:15.942623+00', 'otp', '2ad6c59d-ef06-4e56-805b-85094b4b2b39'),
	('85a3e4db-23b9-4607-ad53-3b6257bb0af2', '2026-09-20 16:26:37.305836+00', '2026-09-20 16:26:37.305836+00', 'anonymous', 'ef975b23-3580-4504-b0f4-d3103f947c63');


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
	('00000000-0000-0000-0000-000000000000', 4, 'qs2j3kyirjmo', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 10:36:31.474737+00', '2026-09-20 11:34:36.059891+00', NULL, '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 5, 'taez7xfxilxs', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 10:46:51.866411+00', '2026-09-20 11:45:20.520499+00', '6qjxy5ygme33', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 7, '67uukfwg4euw', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 11:34:36.082785+00', '2026-09-20 12:32:41.652556+00', 'qs2j3kyirjmo', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 8, 'pkla3ha6gidn', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 11:45:20.539895+00', '2026-09-20 13:01:13.247924+00', 'taez7xfxilxs', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 9, 'v7fotxzsophl', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 12:32:41.679735+00', '2026-09-20 13:30:59.744672+00', '67uukfwg4euw', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 10, 'qgzm2qvp62lq', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 13:01:13.261355+00', '2026-09-20 13:59:23.454336+00', 'pkla3ha6gidn', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 11, 'ql57mqlraw2o', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 13:30:59.762227+00', '2026-09-20 14:29:30.412832+00', 'v7fotxzsophl', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 12, '6afyumh5xv2u', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 13:59:23.474515+00', '2026-09-20 14:57:34.885019+00', 'qgzm2qvp62lq', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 6, '2h6r2rli2rvs', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', true, '2026-09-20 11:07:57.265795+00', '2026-09-20 14:57:38.132901+00', NULL, 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 15, 'kb3y2tqikbb2', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', false, '2026-09-20 14:57:38.133258+00', '2026-09-20 14:57:38.133258+00', '2h6r2rli2rvs', 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 16, 'wohzjiglvlmp', 'd0e19909-c50f-40f6-a7c0-ac3d95d58979', false, '2026-09-20 14:58:56.959216+00', '2026-09-20 14:58:56.959216+00', NULL, '708230cf-ee0c-47a8-9224-3d35e4d9a651'),
	('00000000-0000-0000-0000-000000000000', 17, 'l23art5mrxvg', '89ed9f44-e323-445f-9301-898ea326f408', false, '2026-09-20 15:00:04.073504+00', '2026-09-20 15:00:04.073504+00', NULL, '5c66ea44-4116-4801-ad5c-a0710ab0fe82'),
	('00000000-0000-0000-0000-000000000000', 18, '4dgc7zswm42c', '81dc13f4-562e-4e26-9b86-c1f9fee30446', false, '2026-09-20 15:00:51.309921+00', '2026-09-20 15:00:51.309921+00', NULL, '3fdc0625-9d58-4629-9437-557c3aee5752'),
	('00000000-0000-0000-0000-000000000000', 19, 'peotpfnk2k72', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 15:07:09.175552+00', '2026-09-20 15:07:09.175552+00', NULL, '5206ac96-8674-4256-a49c-746ba780a987'),
	('00000000-0000-0000-0000-000000000000', 20, 'p4o3lmfyvjze', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 15:25:46.996892+00', '2026-09-20 15:25:46.996892+00', NULL, 'bfd7408d-960d-43bc-9fe2-4f93d1ae2803'),
	('00000000-0000-0000-0000-000000000000', 13, 's62jwjlydatv', '3c72b41b-9435-4c18-8048-bdb4e64bc719', true, '2026-09-20 14:29:30.429381+00', '2026-09-20 15:27:37.974471+00', 'ql57mqlraw2o', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 21, 'yomjoaypbjz5', '3c72b41b-9435-4c18-8048-bdb4e64bc719', false, '2026-09-20 15:27:37.978018+00', '2026-09-20 15:27:37.978018+00', 's62jwjlydatv', '08f6a44e-e74d-49ce-b522-4d3515541e3b'),
	('00000000-0000-0000-0000-000000000000', 23, 'c74wamjcgb4j', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', true, '2026-09-20 16:26:37.300339+00', '2026-09-20 17:24:59.982745+00', NULL, '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 24, 'joxsnqc3sue3', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', false, '2026-09-20 17:24:59.993857+00', '2026-09-20 17:24:59.993857+00', 'c74wamjcgb4j', '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 22, 'wrvykyjbvzj4', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 16:20:15.920197+00', '2026-09-20 17:30:54.103188+00', NULL, 'c9d751fb-f3d2-49ad-8ebc-539562e3b9e2'),
	('00000000-0000-0000-0000-000000000000', 14, 'nw53jipvfbbj', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 14:57:34.899385+00', '2026-09-20 18:00:20.288553+00', '6afyumh5xv2u', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 25, 'jvm5uh7xk7ft', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 17:30:54.107866+00', '2026-09-20 18:48:15.382624+00', 'wrvykyjbvzj4', 'c9d751fb-f3d2-49ad-8ebc-539562e3b9e2'),
	('00000000-0000-0000-0000-000000000000', 27, 'v3wvisd2u2p4', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 18:48:15.399566+00', '2026-09-20 18:48:15.399566+00', 'jvm5uh7xk7ft', 'c9d751fb-f3d2-49ad-8ebc-539562e3b9e2'),
	('00000000-0000-0000-0000-000000000000', 26, 'dllqma33srte', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', true, '2026-09-20 18:00:20.298288+00', '2026-09-20 18:58:37.537845+00', 'nw53jipvfbbj', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b'),
	('00000000-0000-0000-0000-000000000000', 28, '3qdisj24r5wn', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-20 18:58:37.543841+00', '2026-09-20 18:58:37.543841+00', 'dllqma33srte', 'ee3e204a-19f5-44fa-87b5-37f8b692c50b');


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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 28, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict J5A9uROoQGTUWjATofRshmrIGCOEYulY2ee9gg8qJ6odA8MKt0N1PM5SgZ01l7X

RESET ALL;
