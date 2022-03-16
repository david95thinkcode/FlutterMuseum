-- -------------------------------------------------------------
-- TablePlus 4.6.0(406)
--
-- https://tableplus.com/
--
-- Database: sqlitedatabase.db
-- Generation Time: 2022-03-15 12:59:25.7670
-- -------------------------------------------------------------


CREATE TABLE "museum" (
	"numMus"	INTEGER NOT NULL UNIQUE,
	"nomMus"	TEXT NOT NULL,
	"nblivres"	INTEGER DEFAULT 0,
	"codepays"	TEXT,
	PRIMARY KEY("numMus" AUTOINCREMENT)
);

INSERT INTO "museum" ("numMus", "nomMus", "nblivres", "codepays") VALUES
('1', 'Musée de l''UNESCO', '560', 'bj'),
('2', 'United State of America Museum', '36000', 'us');
