CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE EXTENSION pg_trgm;
CREATE EXTENSION btree_gin;
CREATE EXTENSION btree_gist;

CREATE INDEX author_idx ON books(author);
CREATE INDEX genre_idx  ON books USING HASH (genre);
