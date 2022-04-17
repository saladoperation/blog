DROP TABLE entries;
CREATE TABLE entries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    text TEXT NOT NULL UNIQUE
);