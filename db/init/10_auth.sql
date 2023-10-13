
-- Setup authenticator
CREATE ROLE postgrest WITH LOGIN PASSWORD 'postgrest';
CREATE ROLE authenticator NOLOGIN;
GRANT authenticator TO postgrest;

-- Setup web_anon
CREATE ROLE web_anon NOLOGIN;
GRANT SELECT ON users TO web_anon;
GRANT web_anon TO authenticator;

-- Setup todo_user
create role todo_user nologin;
grant todo_user to authenticator;
grant usage on schema public to todo_user;

grant all on public.users to todo_user;
grant all on public.todos to todo_user;
grant usage, select on sequence public.users_id_seq to todo_user;
grant usage, select on sequence public.todos_id_seq to todo_user;