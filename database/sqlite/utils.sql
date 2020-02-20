INSERT INTO artigo_tag(artigo_id, tag_id) VALUES(4, 2)



select a.id, a.titulo, t.nome
from artigo a
inner join artigo_tag at on at.artigo_id = a.id
inner join tag t on t.id =  at.tag_id;





-- #############################################
-- Tabelas
-- #############################################
CREATE TABLE IF NOT EXISTS "tag" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nome"	TEXT
);
INSERT INTO tag VALUES(1,'Java');
INSERT INTO tag VALUES(2,'C#');
INSERT INTO tag VALUES(3,'Bençãos de Deus');
CREATE TABLE IF NOT EXISTS "artigo_tag" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"artigo_id"	INTEGER REFERENCES artigo(id),
	"tag_id"	INTEGER REFERENCES tag(id)
);
