
create table todos (
                       id serial primary key,
                       done boolean not null default false,
                       task text not null,
                       due timestamptz
);

insert into todos (task) values
                             ('finish tutorial 0'), ('pat self on back');

CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       password VARCHAR(50) NOT NULL,
                       email VARCHAR(355) UNIQUE NOT NULL,
                       created_on TIMESTAMP NOT NULL,
                       last_login TIMESTAMP
);
