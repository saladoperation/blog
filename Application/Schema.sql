-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE entries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    text TEXT NOT NULL UNIQUE
);
CREATE TABLE examples (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    entry_id UUID NOT NULL,
    "start" INT NOT NULL
);
CREATE INDEX examples_user_id_index ON examples (user_id);
CREATE INDEX examples_entry_id_index ON examples (entry_id);
ALTER TABLE examples ADD CONSTRAINT examples_ref_entry_id FOREIGN KEY (entry_id) REFERENCES entries (id) ON DELETE NO ACTION;
ALTER TABLE examples ADD CONSTRAINT examples_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
