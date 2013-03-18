

CREATE TABLE "AMPTA_project" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "description" text NOT NULL,
    "start_date" datetime NOT NULL,
    "end_date" datetime NOT NULL,
    "owner_id" integer NOT NULL REFERENCES "auth_user" ("id")
);
INSERT INTO "AMPTA_project" VALUES (1, 'Testprojekt', 'Första projektet', '2013-03-07 12:12:29', '2013-03-08 12:12:34', 1);


CREATE INDEX "AMPTA_project_cb902d83" ON "AMPTA_project" ("owner_id");

CREATE TABLE "AMPTA_project_members" (
    "id" integer NOT NULL PRIMARY KEY,
    "project_id" integer NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    UNIQUE ("project_id", "user_id")
);
INSERT INTO "AMPTA_project_members" VALUES (1, 1, 1);


CREATE INDEX "AMPTA_project_members_37952554" ON "AMPTA_project_members" ("project_id");
CREATE INDEX "AMPTA_project_members_6340c63c" ON "AMPTA_project_members" ("user_id");

CREATE TABLE "AMPTA_status" (
    "id" integer NOT NULL PRIMARY KEY,
    "status_name" varchar(50) NOT NULL
);
INSERT INTO "AMPTA_status" VALUES (1, 'bug');
INSERT INTO "AMPTA_status" VALUES (2, 'won''t fix');


CREATE TABLE "AMPTA_ticket" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "description" text NOT NULL,
    "project_id" integer NOT NULL REFERENCES "AMPTA_project" ("id"),
    "status_id" integer NOT NULL REFERENCES "AMPTA_status" ("id"),
    "owner_id" integer NOT NULL REFERENCES "auth_user" ("id")
);
INSERT INTO "AMPTA_ticket" VALUES (1, 'Testticket', 'En testticket för testprojekt', 1, 2, 1);


CREATE INDEX "AMPTA_ticket_37952554" ON "AMPTA_ticket" ("project_id");
CREATE INDEX "AMPTA_ticket_48fb58bb" ON "AMPTA_ticket" ("status_id");
CREATE INDEX "AMPTA_ticket_cb902d83" ON "AMPTA_ticket" ("owner_id");

CREATE TABLE "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
);


CREATE TABLE "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
);


CREATE INDEX "auth_group_permissions_5f412f9a" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_83d7f98b" ON "auth_group_permissions" ("permission_id");

CREATE TABLE "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
);
INSERT INTO "auth_permission" VALUES (1, 'Can add permission', 1, 'add_permission');
INSERT INTO "auth_permission" VALUES (2, 'Can change permission', 1, 'change_permission');
INSERT INTO "auth_permission" VALUES (3, 'Can delete permission', 1, 'delete_permission');
INSERT INTO "auth_permission" VALUES (4, 'Can add group', 2, 'add_group');
INSERT INTO "auth_permission" VALUES (5, 'Can change group', 2, 'change_group');
INSERT INTO "auth_permission" VALUES (6, 'Can delete group', 2, 'delete_group');
INSERT INTO "auth_permission" VALUES (7, 'Can add user', 3, 'add_user');
INSERT INTO "auth_permission" VALUES (8, 'Can change user', 3, 'change_user');
INSERT INTO "auth_permission" VALUES (9, 'Can delete user', 3, 'delete_user');
INSERT INTO "auth_permission" VALUES (10, 'Can add content type', 4, 'add_contenttype');
INSERT INTO "auth_permission" VALUES (11, 'Can change content type', 4, 'change_contenttype');
INSERT INTO "auth_permission" VALUES (12, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO "auth_permission" VALUES (13, 'Can add session', 5, 'add_session');
INSERT INTO "auth_permission" VALUES (14, 'Can change session', 5, 'change_session');
INSERT INTO "auth_permission" VALUES (15, 'Can delete session', 5, 'delete_session');
INSERT INTO "auth_permission" VALUES (16, 'Can add site', 6, 'add_site');
INSERT INTO "auth_permission" VALUES (17, 'Can change site', 6, 'change_site');
INSERT INTO "auth_permission" VALUES (18, 'Can delete site', 6, 'delete_site');
INSERT INTO "auth_permission" VALUES (19, 'Can add log entry', 7, 'add_logentry');
INSERT INTO "auth_permission" VALUES (20, 'Can change log entry', 7, 'change_logentry');
INSERT INTO "auth_permission" VALUES (21, 'Can delete log entry', 7, 'delete_logentry');
INSERT INTO "auth_permission" VALUES (22, 'Can add project', 8, 'add_project');
INSERT INTO "auth_permission" VALUES (23, 'Can change project', 8, 'change_project');
INSERT INTO "auth_permission" VALUES (24, 'Can delete project', 8, 'delete_project');
INSERT INTO "auth_permission" VALUES (25, 'Can add status', 9, 'add_status');
INSERT INTO "auth_permission" VALUES (26, 'Can change status', 9, 'change_status');
INSERT INTO "auth_permission" VALUES (27, 'Can delete status', 9, 'delete_status');
INSERT INTO "auth_permission" VALUES (28, 'Can add ticket', 10, 'add_ticket');
INSERT INTO "auth_permission" VALUES (29, 'Can change ticket', 10, 'change_ticket');
INSERT INTO "auth_permission" VALUES (30, 'Can delete ticket', 10, 'delete_ticket');


CREATE INDEX "auth_permission_37ef4eb4" ON "auth_permission" ("content_type_id");

CREATE TABLE "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "password" varchar(128) NOT NULL,
    "last_login" datetime NOT NULL,
    "is_superuser" bool NOT NULL,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" datetime NOT NULL
);
INSERT INTO "auth_user" VALUES (1, 'pbkdf2_sha256$10000$BSw8mechpqn6$a32qXXpdUi2lZEF19gWI36PELNO+JIgPhJ0jFTrs/bk=', '2013-03-07 12:12:13.148775', 1, 'admin', '', '', 'mo222ez@student.lnu.se', 1, 1, '2013-03-07 12:10:33.834615');


CREATE TABLE "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
);


CREATE INDEX "auth_user_groups_5f412f9a" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_user_groups_6340c63c" ON "auth_user_groups" ("user_id");

CREATE TABLE "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
);


CREATE INDEX "auth_user_user_permissions_6340c63c" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_83d7f98b" ON "auth_user_user_permissions" ("permission_id");

CREATE TABLE "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY,
    "action_time" datetime NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "content_type_id" integer REFERENCES "django_content_type" ("id"),
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint unsigned NOT NULL,
    "change_message" text NOT NULL
);
INSERT INTO "django_admin_log" VALUES (1, '2013-03-07 12:12:37.710485', 1, 8, '1', 'Project object', 1, '');
INSERT INTO "django_admin_log" VALUES (2, '2013-03-08 08:42:34.505460', 1, 9, '1', 'Status object', 1, '');
INSERT INTO "django_admin_log" VALUES (3, '2013-03-08 08:42:40.221929', 1, 9, '2', 'Status object', 1, '');
INSERT INTO "django_admin_log" VALUES (4, '2013-03-08 08:54:23.758122', 1, 10, '1', 'Ticket object', 1, '');


CREATE INDEX "django_admin_log_37ef4eb4" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_6340c63c" ON "django_admin_log" ("user_id");

CREATE TABLE "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
);
INSERT INTO "django_content_type" VALUES (1, 'permission', 'auth', 'permission');
INSERT INTO "django_content_type" VALUES (2, 'group', 'auth', 'group');
INSERT INTO "django_content_type" VALUES (3, 'user', 'auth', 'user');
INSERT INTO "django_content_type" VALUES (4, 'content type', 'contenttypes', 'contenttype');
INSERT INTO "django_content_type" VALUES (5, 'session', 'sessions', 'session');
INSERT INTO "django_content_type" VALUES (6, 'site', 'sites', 'site');
INSERT INTO "django_content_type" VALUES (7, 'log entry', 'admin', 'logentry');
INSERT INTO "django_content_type" VALUES (8, 'project', 'AMPTA', 'project');
INSERT INTO "django_content_type" VALUES (9, 'status', 'AMPTA', 'status');
INSERT INTO "django_content_type" VALUES (10, 'ticket', 'AMPTA', 'ticket');


CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
);
INSERT INTO "django_session" VALUES ('zxcw4v58af8cifvbq5yol40s24qy0hlu', 'MDgwZTM4MDU4OTQzMmM3NTAyZDQ3NDhkMWZjZDVkOTA3MWQ4ZDQzNjqAAn1xAShVDWhhc19sb2dnZWRfaW5xAohVEl9hdXRoX3VzZXJfYmFja2VuZHEDVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEEVQ1fYXV0aF91c2VyX2lkcQVLAXUu', '2013-03-21 12:12:13.151946');


CREATE INDEX "django_session_b7b81f0c" ON "django_session" ("expire_date");

CREATE TABLE "django_site" (
    "id" integer NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
);
INSERT INTO "django_site" VALUES (1, 'example.com', 'example.com');
