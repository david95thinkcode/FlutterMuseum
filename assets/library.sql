-- -------------------------------------------------------------
-- TablePlus 4.6.0(406)
--
-- https://tableplus.com/
--
-- Database: sqlitedatabase.db
-- Generation Time: 2022-03-15 12:59:38.4540
-- -------------------------------------------------------------


CREATE TABLE "library" ("id" integer NOT NULL,"nummus" integer NOT NULL,"isbn" varchar NOT NULL,"dateachat" varchar, PRIMARY KEY (id));

INSERT INTO "library" ("id", "nummus", "isbn", "dateachat") VALUES
('1', '2', '173287980X', NULL);
