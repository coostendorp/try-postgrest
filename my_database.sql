-- Setup authenticator
CREATE ROLE postgrest WITH LOGIN PASSWORD 'postgrest';
create role authenticator noinherit login password 'mysecretpassword';
GRANT authenticator TO postgrest;

-- Setup guest
CREATE ROLE guest NOLOGIN;
GRANT guest TO authenticator;
GRANT USAGE ON SCHEMA public TO guest;

-- Setup normal_user
CREATE ROLE normal_user NOLOGIN;
GRANT normal_user TO authenticator;
GRANT USAGE ON SCHEMA public TO normal_user;

-- Setup admin
CREATE ROLE admin_user NOLOGIN;
GRANT admin_user TO authenticator;
GRANT USAGE ON SCHEMA public TO admin_user;


-- Account table: Definition
CREATE TYPE account_role AS ENUM ('admin_user', 'normal_user', 'guest');

CREATE TABLE account
(
    id         SERIAL PRIMARY KEY,
    email      VARCHAR(355) UNIQUE NOT NULL,
    created_on TIMESTAMP           NOT NULL,
    last_login TIMESTAMP,
    role       account_role        NOT NULL DEFAULT 'normal_user'
);

ALTER TABLE account
    ENABLE ROW LEVEL SECURITY;

-- Account table: Security

CREATE POLICY normal_user_account_select_own ON account
    FOR SELECT
    TO normal_user
    USING (id = (CURRENT_SETTING('request.jwt.claims', TRUE)::json ->> 'sub')::integer);

CREATE POLICY normal_user_account_update_own ON account
    FOR UPDATE
    TO normal_user
    USING (id = (CURRENT_SETTING('request.jwt.claims', TRUE)::json ->> 'sub')::integer);

GRANT SELECT (id, email), UPDATE (email) ON account TO normal_user;


GRANT SELECT, INSERT, DELETE ON account TO admin_user;

-- todos table: Definition

CREATE TABLE todo
(
    id         serial PRIMARY KEY,
    done       boolean NOT NULL DEFAULT FALSE,
    task       text    NOT NULL,
    due        timestamptz,
    account_id int REFERENCES account
);
ALTER TABLE todo
    ENABLE ROW LEVEL SECURITY;

CREATE POLICY guest_todo_select ON todo
    FOR SELECT
    USING (true);

CREATE POLICY normal_user_todo_select_own ON todo
    FOR ALL
    TO normal_user
    USING (id = (CURRENT_SETTING('request.jwt.claims', TRUE)::json ->> 'sub')::integer);

GRANT ALL ON todo TO admin_user;
GRANT ALL ON todo TO guest;


ALTER TABLE todo
    FORCE ROW LEVEL SECURITY;

-- todos table: Security


--
-- grant all on public.users to todo_user;
-- grant all on public.todos to todo_user;
-- grant usage, select on sequence public.account_id_seq to todo_user;
-- grant usage, select on sequence public.todos_id_seq to todo_user;