CREATE TABLE examples (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    entry_id UUID NOT NULL,
    start_time INT NOT NULL
);
CREATE INDEX examples_user_id_index ON examples (user_id);
CREATE INDEX examples_entry_id_index ON examples (entry_id);
ALTER TABLE examples ADD CONSTRAINT examples_ref_entry_id FOREIGN KEY (entry_id) REFERENCES entries (id) ON DELETE NO ACTION;
ALTER TABLE examples ADD CONSTRAINT examples_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
