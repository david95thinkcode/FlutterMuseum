-- -------------------------------------------------------------
-- TablePlus 4.6.0(406)
--
-- https://tableplus.com/
--
-- Database: sqlitedatabase.db
-- Generation Time: 2022-03-15 12:58:15.5380
-- -------------------------------------------------------------


CREATE TABLE "country" (
	"codepays"	TEXT NOT NULL UNIQUE,
	"nbhabitant"	INTEGER DEFAULT 0,
	PRIMARY KEY("codepays")
);

INSERT INTO "country" ("codepays", "nbhabitant") VALUES
('bj', '12123200'),
('cn', '1439323776'),
('de', '83783942'),
('gh', '31072940'),
('ke', '53771296'),
('ng', '206,139,589'),
('ru', '145934462'),
('tg', '8278724'),
('us', '331002651'),
('za', '59308690');
