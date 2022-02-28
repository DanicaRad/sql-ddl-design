-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/9LSEUj
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP DATABASE craigslist_db;
CREATE DATABASE craigslist_db;
\c craigslist_db;

CREATE TABLE regions (
    id SERIAL   NOT NULL,
    region TEXT   NOT NULL,
    CONSTRAINT pk_regions PRIMARY KEY (
        id
     )
);

CREATE TABLE users (
    id SERIAL   NOT NULL,
    name text   NOT NULL,
    region_id int   NOT NULL,
    CONSTRAINT pk_users PRIMARY KEY (
        id
     )
);

CREATE TABLE posts (
    id SERIAL   NOT NULL,
    title VARCHAR(100)   NOT NULL,
    text TEXT,
    category TEXT   NOT NULL,
    user_id INT   NOT NULL,
    location TEXT,
    region_id INT   NOT NULL,
    CONSTRAINT pk_posts PRIMARY KEY (
        id
     )
);

CREATE TABLE categories (
    id SERIAL   NOT NULL,
    category VARCHAR(200)   NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (
        id
     ),
    CONSTRAINT uc_categories_category UNIQUE (
        category
    )
);

ALTER TABLE users ADD CONSTRAINT fk_users_region_id FOREIGN KEY(region_id)
REFERENCES regions (id);

ALTER TABLE posts ADD CONSTRAINT fk_posts_category FOREIGN KEY(category)
REFERENCES categories (id);

ALTER TABLE posts ADD CONSTRAINT fk_posts_user_id FOREIGN KEY(user_id)
REFERENCES users (id);

ALTER TABLE posts ADD CONSTRAINT fk_posts_region_id FOREIGN KEY(region_id)
REFERENCES regions (id);

INSERT INTO regions (region) VALUES ('San Francisco'), ('Atlanta'), ('Seattle'), ('Los Angeles');

INSERT INTO users (name, region_id) VALUES ('Danica', 1), ('Bill', 2), ('Mera', 4), ('Lauren', 3), ('Christie', 2);

INSERT INTO posts (title, text, category, user_id, location, region_id) VALUES ('Couch for sale', ';kajdf', 1, 3, 'Emmeryville', 1), ('Apartment for rent', 'kjhbkjbn', 3, 2, 'Buckhead', 2), ('contractor wanted', '', 4, 4, 'Downtown', 3);

INSERT INTO categories (category) VALUES ('for sale by owner'), ('jobs'), ('for-rent'), ('gigs'), ('random');

