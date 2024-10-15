

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


CREATE EXTENSION IF NOT EXISTS "pg_net" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."directus_access" (
    "id" "uuid" NOT NULL,
    "role" "uuid",
    "user" "uuid",
    "policy" "uuid" NOT NULL,
    "sort" integer
);


ALTER TABLE "public"."directus_access" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_activity" (
    "id" integer NOT NULL,
    "action" character varying(45) NOT NULL,
    "user" "uuid",
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "ip" character varying(50),
    "user_agent" "text",
    "collection" character varying(64) NOT NULL,
    "item" character varying(255) NOT NULL,
    "comment" "text",
    "origin" character varying(255)
);


ALTER TABLE "public"."directus_activity" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_activity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_activity_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_activity_id_seq" OWNED BY "public"."directus_activity"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_collections" (
    "collection" character varying(64) NOT NULL,
    "icon" character varying(64),
    "note" "text",
    "display_template" character varying(255),
    "hidden" boolean DEFAULT false NOT NULL,
    "singleton" boolean DEFAULT false NOT NULL,
    "translations" "json",
    "archive_field" character varying(64),
    "archive_app_filter" boolean DEFAULT true NOT NULL,
    "archive_value" character varying(255),
    "unarchive_value" character varying(255),
    "sort_field" character varying(64),
    "accountability" character varying(255) DEFAULT 'all'::character varying,
    "color" character varying(255),
    "item_duplication_fields" "json",
    "sort" integer,
    "group" character varying(64),
    "collapse" character varying(255) DEFAULT 'open'::character varying NOT NULL,
    "preview_url" character varying(255),
    "versioning" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."directus_collections" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_dashboards" (
    "id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "icon" character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    "note" "text",
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "user_created" "uuid",
    "color" character varying(255)
);


ALTER TABLE "public"."directus_dashboards" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_extensions" (
    "enabled" boolean DEFAULT true NOT NULL,
    "id" "uuid" NOT NULL,
    "folder" character varying(255) NOT NULL,
    "source" character varying(255) NOT NULL,
    "bundle" "uuid"
);


ALTER TABLE "public"."directus_extensions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_fields" (
    "id" integer NOT NULL,
    "collection" character varying(64) NOT NULL,
    "field" character varying(64) NOT NULL,
    "special" character varying(64),
    "interface" character varying(64),
    "options" "json",
    "display" character varying(64),
    "display_options" "json",
    "readonly" boolean DEFAULT false NOT NULL,
    "hidden" boolean DEFAULT false NOT NULL,
    "sort" integer,
    "width" character varying(30) DEFAULT 'full'::character varying,
    "translations" "json",
    "note" "text",
    "conditions" "json",
    "required" boolean DEFAULT false,
    "group" character varying(64),
    "validation" "json",
    "validation_message" "text"
);


ALTER TABLE "public"."directus_fields" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_fields_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_fields_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_fields_id_seq" OWNED BY "public"."directus_fields"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_files" (
    "id" "uuid" NOT NULL,
    "storage" character varying(255) NOT NULL,
    "filename_disk" character varying(255),
    "filename_download" character varying(255) NOT NULL,
    "title" character varying(255),
    "type" character varying(255),
    "folder" "uuid",
    "uploaded_by" "uuid",
    "created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "modified_by" "uuid",
    "modified_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "charset" character varying(50),
    "filesize" bigint,
    "width" integer,
    "height" integer,
    "duration" integer,
    "embed" character varying(200),
    "description" "text",
    "location" "text",
    "tags" "text",
    "metadata" "json",
    "focal_point_x" integer,
    "focal_point_y" integer,
    "tus_id" character varying(64),
    "tus_data" "json",
    "uploaded_on" timestamp with time zone
);


ALTER TABLE "public"."directus_files" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_flows" (
    "id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "icon" character varying(64),
    "color" character varying(255),
    "description" "text",
    "status" character varying(255) DEFAULT 'active'::character varying NOT NULL,
    "trigger" character varying(255),
    "accountability" character varying(255) DEFAULT 'all'::character varying,
    "options" "json",
    "operation" "uuid",
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "user_created" "uuid"
);


ALTER TABLE "public"."directus_flows" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_folders" (
    "id" "uuid" NOT NULL,
    "name" character varying(255) NOT NULL,
    "parent" "uuid"
);


ALTER TABLE "public"."directus_folders" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_migrations" (
    "version" character varying(255) NOT NULL,
    "name" character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."directus_migrations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_notifications" (
    "id" integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "status" character varying(255) DEFAULT 'inbox'::character varying,
    "recipient" "uuid" NOT NULL,
    "sender" "uuid",
    "subject" character varying(255) NOT NULL,
    "message" "text",
    "collection" character varying(64),
    "item" character varying(255)
);


ALTER TABLE "public"."directus_notifications" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_notifications_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_notifications_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_notifications_id_seq" OWNED BY "public"."directus_notifications"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_operations" (
    "id" "uuid" NOT NULL,
    "name" character varying(255),
    "key" character varying(255) NOT NULL,
    "type" character varying(255) NOT NULL,
    "position_x" integer NOT NULL,
    "position_y" integer NOT NULL,
    "options" "json",
    "resolve" "uuid",
    "reject" "uuid",
    "flow" "uuid" NOT NULL,
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "user_created" "uuid"
);


ALTER TABLE "public"."directus_operations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_panels" (
    "id" "uuid" NOT NULL,
    "dashboard" "uuid" NOT NULL,
    "name" character varying(255),
    "icon" character varying(64) DEFAULT NULL::character varying,
    "color" character varying(10),
    "show_header" boolean DEFAULT false NOT NULL,
    "note" "text",
    "type" character varying(255) NOT NULL,
    "position_x" integer NOT NULL,
    "position_y" integer NOT NULL,
    "width" integer NOT NULL,
    "height" integer NOT NULL,
    "options" "json",
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "user_created" "uuid"
);


ALTER TABLE "public"."directus_panels" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_permissions" (
    "id" integer NOT NULL,
    "collection" character varying(64) NOT NULL,
    "action" character varying(10) NOT NULL,
    "permissions" "json",
    "validation" "json",
    "presets" "json",
    "fields" "text",
    "policy" "uuid" NOT NULL
);


ALTER TABLE "public"."directus_permissions" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_permissions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_permissions_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_permissions_id_seq" OWNED BY "public"."directus_permissions"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_policies" (
    "id" "uuid" NOT NULL,
    "name" character varying(100) NOT NULL,
    "icon" character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    "description" "text",
    "ip_access" "text",
    "enforce_tfa" boolean DEFAULT false NOT NULL,
    "admin_access" boolean DEFAULT false NOT NULL,
    "app_access" boolean DEFAULT false NOT NULL
);


ALTER TABLE "public"."directus_policies" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_presets" (
    "id" integer NOT NULL,
    "bookmark" character varying(255),
    "user" "uuid",
    "role" "uuid",
    "collection" character varying(64),
    "search" character varying(100),
    "layout" character varying(100) DEFAULT 'tabular'::character varying,
    "layout_query" "json",
    "layout_options" "json",
    "refresh_interval" integer,
    "filter" "json",
    "icon" character varying(64) DEFAULT 'bookmark'::character varying,
    "color" character varying(255)
);


ALTER TABLE "public"."directus_presets" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_presets_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_presets_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_presets_id_seq" OWNED BY "public"."directus_presets"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_relations" (
    "id" integer NOT NULL,
    "many_collection" character varying(64) NOT NULL,
    "many_field" character varying(64) NOT NULL,
    "one_collection" character varying(64),
    "one_field" character varying(64),
    "one_collection_field" character varying(64),
    "one_allowed_collections" "text",
    "junction_field" character varying(64),
    "sort_field" character varying(64),
    "one_deselect_action" character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE "public"."directus_relations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_relations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_relations_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_relations_id_seq" OWNED BY "public"."directus_relations"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_revisions" (
    "id" integer NOT NULL,
    "activity" integer NOT NULL,
    "collection" character varying(64) NOT NULL,
    "item" character varying(255) NOT NULL,
    "data" "json",
    "delta" "json",
    "parent" integer,
    "version" "uuid"
);


ALTER TABLE "public"."directus_revisions" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_revisions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_revisions_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_revisions_id_seq" OWNED BY "public"."directus_revisions"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_roles" (
    "id" "uuid" NOT NULL,
    "name" character varying(100) NOT NULL,
    "icon" character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    "description" "text",
    "parent" "uuid"
);


ALTER TABLE "public"."directus_roles" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_sessions" (
    "token" character varying(64) NOT NULL,
    "user" "uuid",
    "expires" timestamp with time zone NOT NULL,
    "ip" character varying(255),
    "user_agent" "text",
    "share" "uuid",
    "origin" character varying(255),
    "next_token" character varying(64)
);


ALTER TABLE "public"."directus_sessions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_settings" (
    "id" integer NOT NULL,
    "project_name" character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    "project_url" character varying(255),
    "project_color" character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    "project_logo" "uuid",
    "public_foreground" "uuid",
    "public_background" "uuid",
    "public_note" "text",
    "auth_login_attempts" integer DEFAULT 25,
    "auth_password_policy" character varying(100),
    "storage_asset_transform" character varying(7) DEFAULT 'all'::character varying,
    "storage_asset_presets" "json",
    "custom_css" "text",
    "storage_default_folder" "uuid",
    "basemaps" "json",
    "mapbox_key" character varying(255),
    "module_bar" "json",
    "project_descriptor" character varying(100),
    "default_language" character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    "custom_aspect_ratios" "json",
    "public_favicon" "uuid",
    "default_appearance" character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    "default_theme_light" character varying(255),
    "theme_light_overrides" "json",
    "default_theme_dark" character varying(255),
    "theme_dark_overrides" "json",
    "report_error_url" character varying(255),
    "report_bug_url" character varying(255),
    "report_feature_url" character varying(255),
    "public_registration" boolean DEFAULT false NOT NULL,
    "public_registration_verify_email" boolean DEFAULT true NOT NULL,
    "public_registration_role" "uuid",
    "public_registration_email_filter" "json"
);


ALTER TABLE "public"."directus_settings" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_settings_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_settings_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_settings_id_seq" OWNED BY "public"."directus_settings"."id";



CREATE TABLE IF NOT EXISTS "public"."directus_shares" (
    "id" "uuid" NOT NULL,
    "name" character varying(255),
    "collection" character varying(64) NOT NULL,
    "item" character varying(255) NOT NULL,
    "role" "uuid",
    "password" character varying(255),
    "user_created" "uuid",
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "date_start" timestamp with time zone,
    "date_end" timestamp with time zone,
    "times_used" integer DEFAULT 0,
    "max_uses" integer
);


ALTER TABLE "public"."directus_shares" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_translations" (
    "id" "uuid" NOT NULL,
    "language" character varying(255) NOT NULL,
    "key" character varying(255) NOT NULL,
    "value" "text" NOT NULL
);


ALTER TABLE "public"."directus_translations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_users" (
    "id" "uuid" NOT NULL,
    "first_name" character varying(50),
    "last_name" character varying(50),
    "email" character varying(128),
    "password" character varying(255),
    "location" character varying(255),
    "title" character varying(50),
    "description" "text",
    "tags" "json",
    "avatar" "uuid",
    "language" character varying(255) DEFAULT NULL::character varying,
    "tfa_secret" character varying(255),
    "status" character varying(16) DEFAULT 'active'::character varying NOT NULL,
    "role" "uuid",
    "token" character varying(255),
    "last_access" timestamp with time zone,
    "last_page" character varying(255),
    "provider" character varying(128) DEFAULT 'default'::character varying NOT NULL,
    "external_identifier" character varying(255),
    "auth_data" "json",
    "email_notifications" boolean DEFAULT true,
    "appearance" character varying(255),
    "theme_dark" character varying(255),
    "theme_light" character varying(255),
    "theme_light_overrides" "json",
    "theme_dark_overrides" "json"
);


ALTER TABLE "public"."directus_users" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_versions" (
    "id" "uuid" NOT NULL,
    "key" character varying(64) NOT NULL,
    "name" character varying(255),
    "collection" character varying(64) NOT NULL,
    "item" character varying(255) NOT NULL,
    "hash" character varying(255),
    "date_created" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "date_updated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "user_created" "uuid",
    "user_updated" "uuid"
);


ALTER TABLE "public"."directus_versions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."directus_webhooks" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL,
    "method" character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    "url" character varying(255) NOT NULL,
    "status" character varying(10) DEFAULT 'active'::character varying NOT NULL,
    "data" boolean DEFAULT true NOT NULL,
    "actions" character varying(100) NOT NULL,
    "collections" character varying(255) NOT NULL,
    "headers" "json",
    "was_active_before_deprecation" boolean DEFAULT false NOT NULL,
    "migrated_flow" "uuid"
);


ALTER TABLE "public"."directus_webhooks" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."directus_webhooks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "public"."directus_webhooks_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."directus_webhooks_id_seq" OWNED BY "public"."directus_webhooks"."id";



ALTER TABLE ONLY "public"."directus_activity" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_activity_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_fields" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_fields_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_notifications" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_notifications_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_permissions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_permissions_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_presets" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_presets_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_relations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_relations_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_revisions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_revisions_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_settings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_settings_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_webhooks" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."directus_webhooks_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."directus_access"
    ADD CONSTRAINT "directus_access_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_activity"
    ADD CONSTRAINT "directus_activity_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_collections"
    ADD CONSTRAINT "directus_collections_pkey" PRIMARY KEY ("collection");



ALTER TABLE ONLY "public"."directus_dashboards"
    ADD CONSTRAINT "directus_dashboards_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_extensions"
    ADD CONSTRAINT "directus_extensions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_fields"
    ADD CONSTRAINT "directus_fields_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_files"
    ADD CONSTRAINT "directus_files_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_flows"
    ADD CONSTRAINT "directus_flows_operation_unique" UNIQUE ("operation");



ALTER TABLE ONLY "public"."directus_flows"
    ADD CONSTRAINT "directus_flows_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_folders"
    ADD CONSTRAINT "directus_folders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_migrations"
    ADD CONSTRAINT "directus_migrations_pkey" PRIMARY KEY ("version");



ALTER TABLE ONLY "public"."directus_notifications"
    ADD CONSTRAINT "directus_notifications_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_reject_unique" UNIQUE ("reject");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_resolve_unique" UNIQUE ("resolve");



ALTER TABLE ONLY "public"."directus_panels"
    ADD CONSTRAINT "directus_panels_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_permissions"
    ADD CONSTRAINT "directus_permissions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_policies"
    ADD CONSTRAINT "directus_policies_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_presets"
    ADD CONSTRAINT "directus_presets_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_relations"
    ADD CONSTRAINT "directus_relations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_revisions"
    ADD CONSTRAINT "directus_revisions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_roles"
    ADD CONSTRAINT "directus_roles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_sessions"
    ADD CONSTRAINT "directus_sessions_pkey" PRIMARY KEY ("token");



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_shares"
    ADD CONSTRAINT "directus_shares_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_translations"
    ADD CONSTRAINT "directus_translations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_users"
    ADD CONSTRAINT "directus_users_email_unique" UNIQUE ("email");



ALTER TABLE ONLY "public"."directus_users"
    ADD CONSTRAINT "directus_users_external_identifier_unique" UNIQUE ("external_identifier");



ALTER TABLE ONLY "public"."directus_users"
    ADD CONSTRAINT "directus_users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_users"
    ADD CONSTRAINT "directus_users_token_unique" UNIQUE ("token");



ALTER TABLE ONLY "public"."directus_versions"
    ADD CONSTRAINT "directus_versions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_webhooks"
    ADD CONSTRAINT "directus_webhooks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."directus_access"
    ADD CONSTRAINT "directus_access_policy_foreign" FOREIGN KEY ("policy") REFERENCES "public"."directus_policies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_access"
    ADD CONSTRAINT "directus_access_role_foreign" FOREIGN KEY ("role") REFERENCES "public"."directus_roles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_access"
    ADD CONSTRAINT "directus_access_user_foreign" FOREIGN KEY ("user") REFERENCES "public"."directus_users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_collections"
    ADD CONSTRAINT "directus_collections_group_foreign" FOREIGN KEY ("group") REFERENCES "public"."directus_collections"("collection");



ALTER TABLE ONLY "public"."directus_dashboards"
    ADD CONSTRAINT "directus_dashboards_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_files"
    ADD CONSTRAINT "directus_files_folder_foreign" FOREIGN KEY ("folder") REFERENCES "public"."directus_folders"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_files"
    ADD CONSTRAINT "directus_files_modified_by_foreign" FOREIGN KEY ("modified_by") REFERENCES "public"."directus_users"("id");



ALTER TABLE ONLY "public"."directus_files"
    ADD CONSTRAINT "directus_files_uploaded_by_foreign" FOREIGN KEY ("uploaded_by") REFERENCES "public"."directus_users"("id");



ALTER TABLE ONLY "public"."directus_flows"
    ADD CONSTRAINT "directus_flows_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_folders"
    ADD CONSTRAINT "directus_folders_parent_foreign" FOREIGN KEY ("parent") REFERENCES "public"."directus_folders"("id");



ALTER TABLE ONLY "public"."directus_notifications"
    ADD CONSTRAINT "directus_notifications_recipient_foreign" FOREIGN KEY ("recipient") REFERENCES "public"."directus_users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_notifications"
    ADD CONSTRAINT "directus_notifications_sender_foreign" FOREIGN KEY ("sender") REFERENCES "public"."directus_users"("id");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_flow_foreign" FOREIGN KEY ("flow") REFERENCES "public"."directus_flows"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_reject_foreign" FOREIGN KEY ("reject") REFERENCES "public"."directus_operations"("id");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_resolve_foreign" FOREIGN KEY ("resolve") REFERENCES "public"."directus_operations"("id");



ALTER TABLE ONLY "public"."directus_operations"
    ADD CONSTRAINT "directus_operations_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_panels"
    ADD CONSTRAINT "directus_panels_dashboard_foreign" FOREIGN KEY ("dashboard") REFERENCES "public"."directus_dashboards"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_panels"
    ADD CONSTRAINT "directus_panels_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_permissions"
    ADD CONSTRAINT "directus_permissions_policy_foreign" FOREIGN KEY ("policy") REFERENCES "public"."directus_policies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_presets"
    ADD CONSTRAINT "directus_presets_role_foreign" FOREIGN KEY ("role") REFERENCES "public"."directus_roles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_presets"
    ADD CONSTRAINT "directus_presets_user_foreign" FOREIGN KEY ("user") REFERENCES "public"."directus_users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_revisions"
    ADD CONSTRAINT "directus_revisions_activity_foreign" FOREIGN KEY ("activity") REFERENCES "public"."directus_activity"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_revisions"
    ADD CONSTRAINT "directus_revisions_parent_foreign" FOREIGN KEY ("parent") REFERENCES "public"."directus_revisions"("id");



ALTER TABLE ONLY "public"."directus_revisions"
    ADD CONSTRAINT "directus_revisions_version_foreign" FOREIGN KEY ("version") REFERENCES "public"."directus_versions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_roles"
    ADD CONSTRAINT "directus_roles_parent_foreign" FOREIGN KEY ("parent") REFERENCES "public"."directus_roles"("id");



ALTER TABLE ONLY "public"."directus_sessions"
    ADD CONSTRAINT "directus_sessions_share_foreign" FOREIGN KEY ("share") REFERENCES "public"."directus_shares"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_sessions"
    ADD CONSTRAINT "directus_sessions_user_foreign" FOREIGN KEY ("user") REFERENCES "public"."directus_users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_project_logo_foreign" FOREIGN KEY ("project_logo") REFERENCES "public"."directus_files"("id");



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_public_background_foreign" FOREIGN KEY ("public_background") REFERENCES "public"."directus_files"("id");



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_public_favicon_foreign" FOREIGN KEY ("public_favicon") REFERENCES "public"."directus_files"("id");



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_public_foreground_foreign" FOREIGN KEY ("public_foreground") REFERENCES "public"."directus_files"("id");



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_public_registration_role_foreign" FOREIGN KEY ("public_registration_role") REFERENCES "public"."directus_roles"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_settings"
    ADD CONSTRAINT "directus_settings_storage_default_folder_foreign" FOREIGN KEY ("storage_default_folder") REFERENCES "public"."directus_folders"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_shares"
    ADD CONSTRAINT "directus_shares_collection_foreign" FOREIGN KEY ("collection") REFERENCES "public"."directus_collections"("collection") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_shares"
    ADD CONSTRAINT "directus_shares_role_foreign" FOREIGN KEY ("role") REFERENCES "public"."directus_roles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_shares"
    ADD CONSTRAINT "directus_shares_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_users"
    ADD CONSTRAINT "directus_users_role_foreign" FOREIGN KEY ("role") REFERENCES "public"."directus_roles"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_versions"
    ADD CONSTRAINT "directus_versions_collection_foreign" FOREIGN KEY ("collection") REFERENCES "public"."directus_collections"("collection") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."directus_versions"
    ADD CONSTRAINT "directus_versions_user_created_foreign" FOREIGN KEY ("user_created") REFERENCES "public"."directus_users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."directus_versions"
    ADD CONSTRAINT "directus_versions_user_updated_foreign" FOREIGN KEY ("user_updated") REFERENCES "public"."directus_users"("id");



ALTER TABLE ONLY "public"."directus_webhooks"
    ADD CONSTRAINT "directus_webhooks_migrated_flow_foreign" FOREIGN KEY ("migrated_flow") REFERENCES "public"."directus_flows"("id") ON DELETE SET NULL;





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";





GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";









































































































































































































GRANT ALL ON TABLE "public"."directus_access" TO "anon";
GRANT ALL ON TABLE "public"."directus_access" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_access" TO "service_role";



GRANT ALL ON TABLE "public"."directus_activity" TO "anon";
GRANT ALL ON TABLE "public"."directus_activity" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_activity" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_activity_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_activity_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_activity_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_collections" TO "anon";
GRANT ALL ON TABLE "public"."directus_collections" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_collections" TO "service_role";



GRANT ALL ON TABLE "public"."directus_dashboards" TO "anon";
GRANT ALL ON TABLE "public"."directus_dashboards" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_dashboards" TO "service_role";



GRANT ALL ON TABLE "public"."directus_extensions" TO "anon";
GRANT ALL ON TABLE "public"."directus_extensions" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_extensions" TO "service_role";



GRANT ALL ON TABLE "public"."directus_fields" TO "anon";
GRANT ALL ON TABLE "public"."directus_fields" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_fields" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_fields_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_fields_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_fields_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_files" TO "anon";
GRANT ALL ON TABLE "public"."directus_files" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_files" TO "service_role";



GRANT ALL ON TABLE "public"."directus_flows" TO "anon";
GRANT ALL ON TABLE "public"."directus_flows" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_flows" TO "service_role";



GRANT ALL ON TABLE "public"."directus_folders" TO "anon";
GRANT ALL ON TABLE "public"."directus_folders" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_folders" TO "service_role";



GRANT ALL ON TABLE "public"."directus_migrations" TO "anon";
GRANT ALL ON TABLE "public"."directus_migrations" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_migrations" TO "service_role";



GRANT ALL ON TABLE "public"."directus_notifications" TO "anon";
GRANT ALL ON TABLE "public"."directus_notifications" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_notifications" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_notifications_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_notifications_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_notifications_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_operations" TO "anon";
GRANT ALL ON TABLE "public"."directus_operations" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_operations" TO "service_role";



GRANT ALL ON TABLE "public"."directus_panels" TO "anon";
GRANT ALL ON TABLE "public"."directus_panels" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_panels" TO "service_role";



GRANT ALL ON TABLE "public"."directus_permissions" TO "anon";
GRANT ALL ON TABLE "public"."directus_permissions" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_permissions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_permissions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_permissions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_permissions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_policies" TO "anon";
GRANT ALL ON TABLE "public"."directus_policies" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_policies" TO "service_role";



GRANT ALL ON TABLE "public"."directus_presets" TO "anon";
GRANT ALL ON TABLE "public"."directus_presets" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_presets" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_presets_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_presets_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_presets_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_relations" TO "anon";
GRANT ALL ON TABLE "public"."directus_relations" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_relations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_relations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_relations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_relations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_revisions" TO "anon";
GRANT ALL ON TABLE "public"."directus_revisions" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_revisions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_revisions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_revisions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_revisions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_roles" TO "anon";
GRANT ALL ON TABLE "public"."directus_roles" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_roles" TO "service_role";



GRANT ALL ON TABLE "public"."directus_sessions" TO "anon";
GRANT ALL ON TABLE "public"."directus_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."directus_settings" TO "anon";
GRANT ALL ON TABLE "public"."directus_settings" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_settings" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_settings_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_settings_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_settings_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."directus_shares" TO "anon";
GRANT ALL ON TABLE "public"."directus_shares" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_shares" TO "service_role";



GRANT ALL ON TABLE "public"."directus_translations" TO "anon";
GRANT ALL ON TABLE "public"."directus_translations" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_translations" TO "service_role";



GRANT ALL ON TABLE "public"."directus_users" TO "anon";
GRANT ALL ON TABLE "public"."directus_users" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_users" TO "service_role";



GRANT ALL ON TABLE "public"."directus_versions" TO "anon";
GRANT ALL ON TABLE "public"."directus_versions" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_versions" TO "service_role";



GRANT ALL ON TABLE "public"."directus_webhooks" TO "anon";
GRANT ALL ON TABLE "public"."directus_webhooks" TO "authenticated";
GRANT ALL ON TABLE "public"."directus_webhooks" TO "service_role";



GRANT ALL ON SEQUENCE "public"."directus_webhooks_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."directus_webhooks_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."directus_webhooks_id_seq" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
