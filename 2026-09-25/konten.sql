SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict eDEi2iS6qinpgC64sTGftbAxA3Fa1cvigWsYWPgNyWbs7MlppyJ4Eqi9O2yrc1p

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
	('00000000-0000-0000-0000-000000000000', '0d2426bd-4c99-4746-b5c7-541412a1c778', 'authenticated', 'authenticated', 'luett.matten.de.haas@gmail.com', '$2a$10$KMl6VyeSsgC6t7QPJ7tRN.MvtY1yle3sjW8Acn4b1YlP0OzlSOVg6', '2026-09-22 18:37:23.123509+00', '2026-09-20 10:04:57.74149+00', '', NULL, '', NULL, '', '', NULL, '2026-09-22 18:37:23.132852+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-09-20 10:04:57.703692+00', '2026-09-22 18:37:23.156145+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 16:26:37.294994+00', '{}', '{}', NULL, '2026-09-20 16:26:37.269362+00', '2026-09-23 17:06:21.331932+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-20 11:07:57.257874+00', '{}', '{}', NULL, '2026-09-20 11:07:57.238233+00', '2026-09-25 04:44:25.875146+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true),
	('00000000-0000-0000-0000-000000000000', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', 'authenticated', 'authenticated', 'matthias.haas@errive.de', '$2a$10$R7ecmx9qDyKz1RIBgKQz8eIBqLwyN.xJISVjUi.JgwB61gNk6cfAi', '2026-09-20 08:08:20.434908+00', NULL, '', NULL, '', '2026-09-25 10:11:14.35869+00', '', '', NULL, '2026-09-25 10:11:40.309883+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2026-09-20 08:08:20.409891+00', '2026-09-25 10:11:40.333947+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', 'c7309adf-9737-4eb4-a076-22f734acb551', 'authenticated', 'authenticated', NULL, '', NULL, NULL, '', NULL, '', NULL, '', '', NULL, '2026-09-23 17:11:54.336636+00', '{}', '{}', NULL, '2026-09-23 17:11:54.312352+00', '2026-09-24 19:27:51.573487+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, true);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '{"sub": "4a0ff2b9-34d9-42fa-9a82-00d28ba33a29", "email": "matthias.haas@errive.de", "email_verified": false, "phone_verified": false}', 'email', '2026-09-20 08:08:20.427938+00', '2026-09-20 08:08:20.428007+00', '2026-09-20 08:08:20.428007+00', '45171546-3e2b-4c0b-b12b-d20b2cb03d5b'),
	('0d2426bd-4c99-4746-b5c7-541412a1c778', '0d2426bd-4c99-4746-b5c7-541412a1c778', '{"sub": "0d2426bd-4c99-4746-b5c7-541412a1c778", "email": "luett.matten.de.haas@gmail.com", "email_verified": true, "phone_verified": false}', 'email', '2026-09-20 10:04:57.73587+00', '2026-09-20 10:04:57.735936+00', '2026-09-20 10:04:57.735936+00', '27c132f4-3bad-4744-84f9-bdfecb416e47');


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
	('4b60f80f-0140-4c69-b093-f14e70328ade', 'c7309adf-9737-4eb4-a076-22f734acb551', '2026-09-23 17:11:54.337404+00', '2026-09-24 19:27:51.595075+00', NULL, 'aal1', NULL, '2026-09-24 19:27:51.594899', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '87.188.174.198', NULL, NULL, NULL, NULL, NULL),
	('726a6498-fe9e-4bb4-b667-abe70956cbf5', '0d2426bd-4c99-4746-b5c7-541412a1c778', '2026-09-22 18:37:23.132959+00', '2026-09-22 18:37:23.132959+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/2.2553.1 Chrome/152.0.7977.76 Safari/537.36 MSIX', '84.171.245.231', NULL, NULL, NULL, NULL, NULL),
	('85a3e4db-23b9-4607-ad53-3b6257bb0af2', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', '2026-09-20 16:26:37.297024+00', '2026-09-23 17:06:21.361982+00', NULL, 'aal1', NULL, '2026-09-23 17:06:21.361877', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.244.212', NULL, NULL, NULL, NULL, NULL),
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', '2026-09-20 11:07:57.259978+00', '2026-09-25 04:44:25.900814+00', NULL, 'aal1', NULL, '2026-09-25 04:44:25.900691', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.2 Safari/605.1.15', '84.171.243.199', NULL, NULL, NULL, NULL, NULL),
	('50463bc5-e47c-4fab-8ae7-650fe6b082a7', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-25 08:59:51.66871+00', '2026-09-25 08:59:51.66871+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.243.199', NULL, NULL, NULL, NULL, NULL),
	('64915181-3d53-4831-a67f-ed9da3b2f990', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-25 09:21:28.599881+00', '2026-09-25 09:21:28.599881+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '84.171.243.199', NULL, NULL, NULL, NULL, NULL),
	('3994382c-1bcd-4e1e-8fbc-5253423f6fe7', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', '2026-09-25 10:11:40.309989+00', '2026-09-25 10:11:40.309989+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/2.9939.2 Chrome/152.0.7977.130 Safari/537.36 MSIX', '84.171.243.199', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('efaefbd8-b276-456d-9fc1-28e9e3170ec7', '2026-09-20 11:07:57.282472+00', '2026-09-20 11:07:57.282472+00', 'anonymous', '26d0c58b-ba39-4267-b2f2-edfc25bae7db'),
	('85a3e4db-23b9-4607-ad53-3b6257bb0af2', '2026-09-20 16:26:37.305836+00', '2026-09-20 16:26:37.305836+00', 'anonymous', 'ef975b23-3580-4504-b0f4-d3103f947c63'),
	('726a6498-fe9e-4bb4-b667-abe70956cbf5', '2026-09-22 18:37:23.157463+00', '2026-09-22 18:37:23.157463+00', 'otp', '334d8800-2fcc-45eb-887c-23d79c73cc09'),
	('4b60f80f-0140-4c69-b093-f14e70328ade', '2026-09-23 17:11:54.350005+00', '2026-09-23 17:11:54.350005+00', 'anonymous', 'cae62abd-3b6d-4246-b10d-0271e140e642'),
	('50463bc5-e47c-4fab-8ae7-650fe6b082a7', '2026-09-25 08:59:51.690896+00', '2026-09-25 08:59:51.690896+00', 'otp', '7b10e668-c21a-4a4e-b51b-9b88dc61b3fa'),
	('64915181-3d53-4831-a67f-ed9da3b2f990', '2026-09-25 09:21:28.63479+00', '2026-09-25 09:21:28.63479+00', 'otp', 'c60ffd9f-6f1b-46e6-8252-ec2e8f7b354c'),
	('3994382c-1bcd-4e1e-8fbc-5253423f6fe7', '2026-09-25 10:11:40.335956+00', '2026-09-25 10:11:40.335956+00', 'otp', '40c41f2b-eb03-4f38-9a99-7a08071bb8a8');


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



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 162, 'bvy5ky6hwsyu', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-25 08:59:51.679572+00', '2026-09-25 08:59:51.679572+00', NULL, '50463bc5-e47c-4fab-8ae7-650fe6b082a7'),
	('00000000-0000-0000-0000-000000000000', 24, 'joxsnqc3sue3', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', true, '2026-09-20 17:24:59.993857+00', '2026-09-22 14:42:36.490048+00', 'c74wamjcgb4j', '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 65, '2bvk2a6xifdt', '0d2426bd-4c99-4746-b5c7-541412a1c778', false, '2026-09-22 18:37:23.137945+00', '2026-09-22 18:37:23.137945+00', NULL, '726a6498-fe9e-4bb4-b667-abe70956cbf5'),
	('00000000-0000-0000-0000-000000000000', 6, '2h6r2rli2rvs', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', true, '2026-09-20 11:07:57.265795+00', '2026-09-20 14:57:38.132901+00', NULL, 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 23, 'c74wamjcgb4j', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', true, '2026-09-20 16:26:37.300339+00', '2026-09-20 17:24:59.982745+00', NULL, '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 61, 'hk5y4g7z57iq', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', true, '2026-09-22 14:42:36.507259+00', '2026-09-23 17:06:21.311396+00', 'joxsnqc3sue3', '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 15, 'kb3y2tqikbb2', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', true, '2026-09-20 14:57:38.133258+00', '2026-09-23 17:11:21.617668+00', '2h6r2rli2rvs', 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 163, 'ubzcwe6bzxmu', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-25 09:21:28.611952+00', '2026-09-25 09:21:28.611952+00', NULL, '64915181-3d53-4831-a67f-ed9da3b2f990'),
	('00000000-0000-0000-0000-000000000000', 98, 'tu3c3nhyc2j6', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', true, '2026-09-23 17:11:21.623955+00', '2026-09-25 04:44:25.864293+00', 'kb3y2tqikbb2', 'efaefbd8-b276-456d-9fc1-28e9e3170ec7'),
	('00000000-0000-0000-0000-000000000000', 96, '52kx6jatywdo', 'e1834b95-7c6a-474b-9c39-1a1175f3b7a5', false, '2026-09-23 17:06:21.323249+00', '2026-09-23 17:06:21.323249+00', 'hk5y4g7z57iq', '85a3e4db-23b9-4607-ad53-3b6257bb0af2'),
	('00000000-0000-0000-0000-000000000000', 99, 'mx66tp4qz4gq', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-23 17:11:54.347646+00', '2026-09-23 19:23:39.569135+00', NULL, '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 105, '7rlp52ey7vl4', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-23 19:23:39.58732+00', '2026-09-24 04:06:56.476261+00', 'mx66tp4qz4gq', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 111, 'x3jfczjapfaj', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 04:06:56.488873+00', '2026-09-24 05:46:59.583703+00', '7rlp52ey7vl4', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 113, 'uwujtbwi4ouu', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 05:46:59.603247+00', '2026-09-24 06:45:12.451539+00', 'x3jfczjapfaj', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 116, 'geu3qdndt4ga', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 06:45:12.464663+00', '2026-09-24 08:02:07.986447+00', 'uwujtbwi4ouu', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 121, 'l5dsb3ejj54j', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 08:02:07.997498+00', '2026-09-24 09:07:43.225364+00', 'geu3qdndt4ga', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 164, 'm6r5hagztzkl', '4a0ff2b9-34d9-42fa-9a82-00d28ba33a29', false, '2026-09-25 10:11:40.321503+00', '2026-09-25 10:11:40.321503+00', NULL, '3994382c-1bcd-4e1e-8fbc-5253423f6fe7'),
	('00000000-0000-0000-0000-000000000000', 131, 'etfpnzy37qui', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 11:09:50.053214+00', '2026-09-24 13:16:55.427505+00', 'izwp6atwrzeq', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 124, 'm2f4d4g722in', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 09:07:43.231919+00', '2026-09-24 10:06:06.866224+00', 'l5dsb3ejj54j', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 127, 'izwp6atwrzeq', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 10:06:06.875132+00', '2026-09-24 11:09:50.051217+00', 'm2f4d4g722in', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 136, 'kbr7vutoygls', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 13:16:55.440323+00', '2026-09-24 15:11:18.515143+00', 'etfpnzy37qui', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 141, '6lysxc4bhwvt', 'c7309adf-9737-4eb4-a076-22f734acb551', true, '2026-09-24 15:11:18.528775+00', '2026-09-24 19:27:51.547983+00', 'kbr7vutoygls', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 148, 'eyb54rg5vsxy', 'c7309adf-9737-4eb4-a076-22f734acb551', false, '2026-09-24 19:27:51.561703+00', '2026-09-24 19:27:51.561703+00', '6lysxc4bhwvt', '4b60f80f-0140-4c69-b093-f14e70328ade'),
	('00000000-0000-0000-0000-000000000000', 153, 'wedgbebk6oqo', 'd0bc23e3-7320-4c6a-a938-2f32e916d117', false, '2026-09-25 04:44:25.871201+00', '2026-09-25 04:44:25.871201+00', 'tu3c3nhyc2j6', 'efaefbd8-b276-456d-9fc1-28e9e3170ec7');


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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 164, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict eDEi2iS6qinpgC64sTGftbAxA3Fa1cvigWsYWPgNyWbs7MlppyJ4Eqi9O2yrc1p

RESET ALL;
