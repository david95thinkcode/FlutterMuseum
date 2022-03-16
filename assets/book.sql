-- -------------------------------------------------------------
-- TablePlus 4.6.0(406)
--
-- https://tableplus.com/
--
-- Database: sqlitedatabase.db
-- Generation Time: 2022-03-15 12:59:09.6240
-- -------------------------------------------------------------


CREATE TABLE "book" (
	"isbn"	TEXT NOT NULL UNIQUE,
	"nbpage"	INTEGER DEFAULT 0,
	"titre"	TEXT,
	"codepays"	TEXT DEFAULT NULL,
	PRIMARY KEY("isbn")
);

INSERT INTO "book" ("isbn", "nbpage", "titre", "codepays") VALUES
('0692079548', '34', 'Smelly Cat: A dog-gone picture book about adoption', 'us'),
('1546258922', '28', 'I Have Big Dreams: Rianna Dreams of Competing in the Olympics', 'us'),
('173287980X', '40', 'The Fearless Fantabulous Five', 'us');
