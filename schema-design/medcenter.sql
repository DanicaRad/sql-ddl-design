-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

DROP DATABASE medcenter_db;
CREATE DATABASE medcenter_db;
\c medcenter_db;

CREATE TABLE "Doctors" (
    "id" SERIAL   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Doctors" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Patients" (
    "id" serial   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_Patients" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "Visits" (
    "id" SERIAL   NOT NULL,
    "patient_id" INT   NOT NULL,
    "doctor_id" INT   NOT NULL,
    "diagnosed" BOOLEAN   NOT NULL,
    "date" TEXT   NOT NULL,
    CONSTRAINT "pk_Visits" PRIMARY KEY (
        "id"
     )
);

-- Table documentation comment 1 (try the PDF/RTF export)
-- Table documentation comment 2
CREATE TABLE "Diseases" (
    "id" SERIAL   NOT NULL,
    -- name of disease/ diagnoses
    "name" varchar(200)   NOT NULL,
    CONSTRAINT "pk_Diseases" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_Diseases_name" UNIQUE (
        "name"
    )
);

CREATE TABLE "Diagnoses" (
    "visit_id" INT   NOT NULL,
    "patient_id" INT   NOT NULL,
    "disease_id" INT   NOT NULL
);

ALTER TABLE "Visits" ADD CONSTRAINT "fk_Visits_patient_id" FOREIGN KEY("patient_id")
REFERENCES "Patients" ("id");

ALTER TABLE "Visits" ADD CONSTRAINT "fk_Visits_doctor_id" FOREIGN KEY("doctor_id")
REFERENCES "Doctors" ("id");

ALTER TABLE "Diagnoses" ADD CONSTRAINT "fk_Diagnoses_visit_id" FOREIGN KEY("visit_id")
REFERENCES "Visits" ("id");

ALTER TABLE "Diagnoses" ADD CONSTRAINT "fk_Diagnoses_patient_id" FOREIGN KEY("patient_id")
REFERENCES "Patients" ("id");

ALTER TABLE "Diagnoses" ADD CONSTRAINT "fk_Diagnoses_disease_id" FOREIGN KEY("disease_id")
REFERENCES "Diseases" ("id");

CREATE INDEX "idx_Doctors_first_name"
ON "Doctors" ("first_name");

CREATE INDEX "idx_Doctors_last_name"
ON "Doctors" ("last_name");

CREATE INDEX "idx_Patients_first_name"
ON "Patients" ("first_name");

CREATE INDEX "idx_Patients_last_name"
ON "Patients" ("last_name");

------------------------------------------------

INSERT INTO "Doctors" (first_name, last_name) 
    VALUES ('Bill', 'Wilson'), ('William', 'Silkworth'), ('Ngoc', 'Phan');

INSERT INTO "Patients" (first_name, last_name) 
    VALUES ('Danica', 'Rad'), ('John', 'Doe'), ('Jane', 'Doe');

INSERT INTO "Visits" (patient_id, doctor_id, diagnosed, date) VALUES (1, 3, false, '2020-10-27'), (2, 1, true, '2021-03-12'), (3, 2, true, '2022-05-19');

INSERT INTO "Diseases" (name) VALUES ('arthiritis'), ('allergies'), ('hypertension'), ('heart disease');

INSERT INTO "Diagnoses" (visit_id, patient_id, disease_id) VALUES (2, 2, 3), (2, 2, 4), (3, 3, 1), (3, 3, 2);