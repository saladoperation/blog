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
    text TEXT NOT NULL UNIQUE,
    user_id UUID NOT NULL
);
CREATE INDEX entries_user_id_index ON entries (user_id);
ALTER TABLE entries ADD CONSTRAINT entries_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
