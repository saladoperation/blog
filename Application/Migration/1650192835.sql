ALTER TABLE examples ADD COLUMN video_id TEXT NULL;
UPDATE examples SET video_id = 'dQw4w9WgXcQ';
ALTER TABLE examples ALTER COLUMN video_id SET NOT NULL;
