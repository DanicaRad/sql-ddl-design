-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artists TEXT[] NOT NULL,
  album TEXT NOT NULL,
  producers TEXT[] NOT NULL
);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artists, album, producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{'Hanson'}', 'Middle of Nowhere', '{'Dust Brothers', 'Stephen Lironi'}'),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{'Queen'}', 'A Night at the Opera', '{'Roy Thomas Baker'}'),
  ('One Sweet Day', 282, '11-14-1995', '{'Mariah Cary', 'Boyz II Men'}', 'Daydream', '{'Walter Afanasieff'}'),
  ('Shallow', 216, '09-27-2018', '{'Lady Gaga', 'Bradley Cooper'}', 'A Star Is Born', '{'Benjamin Rice'}'),
  ('How You Remind Me', 223, '08-21-2001', '{'Nickelback'}', 'Silver Side Up', '{'Rick Parashar'}'),
  ('New York State of Mind', 276, '10-20-2009', '{'Jay Z', 'Alicia Keys'}', 'The Blueprint 3', '{'Al Shux'}'),
  ('Dark Horse', 215, '12-17-2013', '{'Katy Perry', 'Juicy J'}', 'Prism', '{'Max Martin', 'Cirkut'}'),
  ('Moves Like Jagger', 201, '06-21-2011', '{'Maroon 5', 'Christina Aguilera'}', 'Hands All Over', '{'Shellback', 'Benny Blanco'}'),
  ('Complicated', 244, '05-14-2002', '{'Avril Lavigne'}', 'Let Go', '{'The Matrix'}'),
  ('Say My Name', 240, '11-07-1999', '{'Destiny''s Child'}', 'The Writing''s on the Wall', '{'Darkchild'}');


DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE albums
(
  id SERIAL PRIMARY KEY,
  album_name TEXT NOT NULL,
  artist_id INT REFERENCES artists
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INT NOT NULL,
  release_date DATE NOT NULL,
  artist_id INT NOT NULL REFERENCES artists,
  has_guest_artist BOOLEAN NOT NULL,
  album INT NOT NULL REFERENCES albums
);

CREATE TABLE guest_artists
(
  id SERIAL PRIMARY KEY,
  guest_artist_id INT REFERENCES artists,
  song_id INT REFERENCES songs
);

CREATE TABLE producers_songs
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  song_id INT REFERENCES songs
);


INSERT INTO artists (name)
  VALUES
    ('Hanson'), 
    ('Queen'),
    ('Mariah Carey'),
    ('Boyz II Men'),
    ('Lady Gaga'),
    ('Bradley Cooper'), 
    ('Nickelback'),
    ('Jay-z'),
    ('Alicia Keys'),
    ('Katy Perry'),
    ('Juicy J'),
    ('Maroon 5'),
    ('Christina Aguilera'),
    ('Avril Lavigne'),
    ('Destiny''s Child'),
    ('Various Artists');

INSERT INTO albums (album_name, artist_id)
  VALUES
    ('Middle of Nowhere', 1),
    ('A Night at the Opera', 2),
    ('Daydream', 3),
    ('A Star Is Born', 16),
    ('Silver Side Up', 7),
    ('The Blueprint 3', 8),
    ('Prism', 10),
    ('Hands All Over', 12),
    ('Let Go', 14),
    ('The Writing''s on the Wall', 15);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artist_id, has_guest_artist, album)
VALUES
  ('MMMBop', 238, '04-15-1997', 1, false, 1),
  ('Bohemian Rhapsody', 355, '10-31-1975', 2, false, 2),
  ('One Sweet Day', 282, '11-14-1995', 3, true, 3),
  ('Shallow', 216, '09-27-2018', 5, true, 4),
  ('How You Remind Me', 223, '08-21-2001', 7, false, 5),
  ('New York State of Mind', 276, '10-20-2009', 8, true, 6),
  ('Dark Horse', 215, '12-17-2013', 10, true, 7),
  ('Moves Like Jagger', 201, '06-21-2011', 12, true, 8),
  ('Complicated', 244, '05-14-2002', 14, false, 9),
  ('Say My Name', 240, '11-07-1999', 15, false, 10);

INSERT INTO producers_songs (name, song_id)
  VALUES
    ('Dust Brothers', 11),
    ('Stephen Lironi', 11),
    ('Roy Thomas Baker', 12),
    ('Walter Afanasieff', 13),
    ('Benjamin Rice', 14),
    ('Rick Parashar', 15),
    ('Al Shux', 16),
    ('Max Martin', 17),
    ('Cirkut', 17),
    ('Shellback', 18),
    ('Benny Blanco', 18),
    ('The Matrix', 19),
    ('Darkchild', 20);

INSERT INTO guest_artists (guest_artist_id, song_id)
  VALUES
    (4, 13),
    (6, 14),
    (9, 16),
    (11, 17),
    (13, 18);

----------- SHOW ALL SONG DATA -------------

SELECT title, duration_in_seconds, release_date, artists.name, albums.album_name, guest_artist, producers_songs.name as producer
  FROM (
    SELECT a.name as guest_artist, g.song_id
      FROM guest_artists g
      JOIN artists a
        ON g.guest_artist_id = a.id
  ) guests
  RIGHT JOIN songs
    ON guests.song_id = songs.id
  JOIN artists 
    ON artist_id = artists.id
  JOIN albums 
    ON songs.album = albums.id
  JOIN producers_songs
    ON songs.id = producers_songs.song_id;


-- SELECT title, duration_in_seconds, release_date, artists.name, albums.album_name, guest_artist, producers_songs.name as producer
--   FROM (
--     SELECT a.name as guest_artist, g.song_id
--       FROM guest_artists g
--       JOIN artists a
--         ON g.guest_artist_id = a.id
--   ) guests
--   RIGHT JOIN songs
--     ON guests.song_id = songs.id
--   JOIN artists 
--     ON artist_id = artists.id
--   JOIN albums 
--     ON songs.album = albums.id
--   JOIN producers_songs
--     ON songs.id = producers_songs.song_id
--     GROUP BY title;

-- (SELECT s.id, p.name as producer, COUNT(*)
--   FROM songs s
--     JOIN producers_songs p
--     ON s.id = p.song_id
--     GROUP BY s.id;
--   ) guests

-- SELECT song_id, name, COUNT(*)
--   FROM producers_songs
--   GROUP BY song_id;
