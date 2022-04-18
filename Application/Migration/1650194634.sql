DROP INDEX examples_entry_id_index;
DROP INDEX examples_user_id_index;
ALTER TABLE examples DROP CONSTRAINT examples_ref_entry_id;
ALTER TABLE examples DROP CONSTRAINT examples_ref_user_id;
ALTER TABLE examples RENAME TO videos;
CREATE INDEX videos_user_id_index ON videos (user_id);
CREATE INDEX videos_entry_id_index ON videos (entry_id);
ALTER TABLE videos ADD CONSTRAINT videos_ref_entry_id FOREIGN KEY (entry_id) REFERENCES entries (id) ON DELETE NO ACTION;
ALTER TABLE videos ADD CONSTRAINT videos_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
