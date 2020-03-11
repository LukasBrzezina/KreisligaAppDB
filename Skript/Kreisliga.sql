CREATE DATABASE db_kreisliga;
USE db_kreisliga;

CREATE TABLE tbl_rolle
(
    Rolle_ID INT AUTO_INCREMENT NOT NULL,
    rollenbezeichnung VARCHAR(50) NOT NULL,
    PRIMARY KEY(Rolle_ID)
)ENGINE=INNODB;

INSERT INTO tbl_rolle (rollenbezeichnung)
VALUES ("Schiedsrichter"), ("Spieler"), ("Trainer"), ("Vorstand"), ("Vorstand");

CREATE TABLE tbl_liga
(
    Liga_ID INT AUTO_INCREMENT NOT NULL,
    Verband VARCHAR(50) NOT NULL,
    Erstaustragungsdatum DATE NOT NULL,
    PRIMARY KEY(Liga_ID)
)ENGINE=INNODB;

INSERT INTO tbl_Liga(Verband, Erstaustragungsdatum)
VALUES ("DFB", '1923-7-04'), ("ÖFB", '1872-7-04'), ("EFB", '1991-6-06');

CREATE TABLE tbl_verein
(
    Verein_ID INT AUTO_INCREMENT NOT NULL,
    Liga_ID INT NOT NULL,
    Name VARCHAR(40) NOT NULL,
    PRIMARY KEY(Verein_ID),
    CONSTRAINT FK_Liga_Verein FOREIGN KEY (Liga_ID) REFERENCES tbl_liga(Liga_ID)
)ENGINE=INNODB;

INSERT INTO tbl_verein (Liga_ID, Name)
VALUES (1, "1.Fc Köln"), (1, "Borussia Dortmund"), (1, "Bayern München"),  (1, "FC Schalke04"),  (1, "Union Berlin"),  (1, "Bayer Leverkusen"),  (1, "Borussia Mönchengladbach");

CREATE TABLE tbl_user
(
    User_ID INT AUTO_INCREMENT NOT NULL,
    Rolle_ID INT NOT NULL,
    Verein_ID INT NOT NULL,
    Name CHAR(20) NOT NULL,
    Vorname CHAR(40) NOT NULL,
    Geburtsdatum DATE NOT NULL,
    PRIMARY KEY(User_ID),
    CONSTRAINT FK_Rolle_User FOREIGN KEY (Rolle_ID) REFERENCES tbl_rolle(Rolle_ID),
    CONSTRAINT FK_Verein_User FOREIGN KEY (Verein_ID) REFERENCES tbl_verein(Verein_ID)
)ENGINE=INNODB;

INSERT INTO tbl_user (Rolle_ID, Verein_ID, Name, Vorname, Geburtsdatum)
VALUES (2, 5, "Brzezina", "Lukas", '2001-7-18'), (3, 4, "Schablitzki", "Nils", '2000-3-08'), (2, 5, "Schoska", "Niklas", '2000-5-13');

CREATE TABLE tbl_nachrichten
(
    Nachrichten_ID INT AUTO_INCREMENT NOT NULL,
    User_ID INT NOT NULL,
    Beschreibung VARCHAR(50) NOT NULL,
    PRIMARY KEY(Nachrichten_ID),
    CONSTRAINT FK_User_Nachrichten FOREIGN KEY (User_ID) REFERENCES tbl_user(User_ID)
)ENGINE=INNODB;

INSERT INTO tbl_nachrichten (User_ID, Beschreibung)
VALUES (1, "Spiel gegen Borussia Dortmund: Falsches Ergebnis 1:0");

CREATE TABLE tbl_spiele
(
    Spiel_ID INT AUTO_INCREMENT NOT NULL,
    Spieltag INT NOT NULL,
    Schiedrichter INT NOT NULL,
    Datum DATE NOT NULL,
    Uhrzeit TIME NOT NULL,
    Heim_V INT NOT NULL,
    Gast_V INT NOT NULL,
    Tore_H INT NOT NULL,
    Tore_G INT NOT NULL,
    PRIMARY KEY(Spiel_ID),
    CONSTRAINT FK_User_Spiel FOREIGN KEY (Schiedrichter) REFERENCES tbl_user(User_ID),
    CONSTRAINT FK_Verein_H_Spiel FOREIGN KEY (Heim_V) REFERENCES tbl_verein(Verein_ID),
    CONSTRAINT FK_Verein_G_Spiel FOREIGN KEY (Gast_V) REFERENCES tbl_verein(Verein_ID)
)ENGINE=INNODB;