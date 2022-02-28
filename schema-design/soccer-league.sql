-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/9LSEUj
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

DROP DATABASE soccer_db;
CREATE DATABASE soccer_db;
\c soccer_db;

CREATE TABLE teams (
    id SERIAL   NOT NULL,
    name TEXT   NOT NULL,
    CONSTRAINT pk_teams PRIMARY KEY (
        id
     )
);

CREATE TABLE players (
    id SERIAL   NOT NULL,
    first_name text   NOT NULL,
    last_name TEXT   NOT NULL,
    team INT   NOT NULL,
    CONSTRAINT pk_players PRIMARY KEY (
        id
     )
);

CREATE TABLE matches (
    id SERIAL   NOT NULL,
    team_1 INT   NOT NULL,
    team_2 INT  NOT NULL,
    winner INT  NOT NULL,
    season_id INT   NOT NULL,
    CONSTRAINT pk_matches PRIMARY KEY (
        id
     )
);

CREATE TABLE seasons (
    id SERIAL   NOT NULL,
    start_date DATE   NOT NULL,
    end_date DATE   NOT NULL,
    CONSTRAINT pk_seasons PRIMARY KEY (
        id
     )
);

CREATE TABLE referees (
    id SERIAL   NOT NULL,
    first_name TEXT   NOT NULL,
    last_name TEXT   NOT NULL,
    CONSTRAINT pk_referees PRIMARY KEY (
        id
     )
);

CREATE TABLE referee_matches (
    referee INT   NOT NULL,
    match_id INT   NOT NULL
);

CREATE TABLE goals (
    id SERIAL   NOT NULL,
    match_id INT   NOT NULL,
    player_id INT   NOT NULL,
    CONSTRAINT pk_goals PRIMARY KEY (
        id
     )
);

ALTER TABLE "players" ADD CONSTRAINT "fk_players_team" FOREIGN KEY("team")
REFERENCES "teams" ("id");

ALTER TABLE "matches" ADD CONSTRAINT "fk_matches_team_1" FOREIGN KEY("team_1")
REFERENCES "teams" ("id");

ALTER TABLE "matches" ADD CONSTRAINT "fk_matches_team_2" FOREIGN KEY("team_2")
REFERENCES "teams" ("id");

ALTER TABLE "matches" ADD CONSTRAINT "fk_matches_winner" FOREIGN KEY("winner")
REFERENCES "teams" ("id");

ALTER TABLE "matches" ADD CONSTRAINT "fk_matches_season_id" FOREIGN KEY("season_id")
REFERENCES "seasons" ("id");

ALTER TABLE "referee_matches" ADD CONSTRAINT "fk_referee_matches_referee" FOREIGN KEY("referee")
REFERENCES "referees" ("id");

ALTER TABLE "referee_matches" ADD CONSTRAINT "fk_referee_matches_match_id" FOREIGN KEY("match_id")
REFERENCES "matches" ("id");

ALTER TABLE "goals" ADD CONSTRAINT "fk_goals_match_id" FOREIGN KEY("match_id")
REFERENCES "matches" ("id");

ALTER TABLE "goals" ADD CONSTRAINT "fk_goals_player_id" FOREIGN KEY("player_id")
REFERENCES "players" ("id");

INSERT INTO teams (name) VALUES ('LA Galaxy'), ('Toronto FC'), ('Austin FC');

INSERT INTO players (first_name, last_name, team) VALUES ('joe', 'schmo', 1), ('another', 'player', 2), ('soccer', 'yay', 3);

INSERT INTO seasons (start_date, end_date) VALUES ('2022-01-01', '2022-12-31'), ('2021-01-01', '2021-12-31'), ('2020-01-01', '2020-12-31');

INSERT INTO matches (team_1, team_2, winner, season_id) VALUES (1, 2, 1, 1), (1, 3, 3, 2), (2, 3, 2, 3);

INSERT INTO referees (first_name, last_name) VALUES ('billy', 'bob'), ('lilly', 'lee'), ('bobby', 'brown');

INSERT INTO referee_matches (referee, match_id) VALUES (1, 5), (2, 5), (3, 4);

INSERT INTO goals (match_id, player_id) VALUES (4, 1), (4, 2), (4, 3), (5, 3), (5, 3), (6, 2), (6, 3);

INSERT INTO matches (team_1, team_2, winner, season_id) VALUES (3, 2, 3, 1), (2, 3, 2, 2), (1, 3, 3, 3), (1, 2, 2, 3);

-------------- SHOW TEAM RANKINGS --------------

SELECT teams.id as team, COUNT(matches.winner) as wins, matches.season_id
    FROM teams
    JOIN matches ON teams.id = matches.winner
    GROUP BY teams.id, matches.season_id
    ORDER BY wins DESC;