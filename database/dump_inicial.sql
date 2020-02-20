CREATE TABLE IF NOT EXISTS "artigo" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"titulo"	TEXT NOT NULL,
	"conteudo"	TEXT
);

CREATE TABLE IF NOT EXISTS "usuario" (
	"id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"login"	TEXT NOT NULL UNIQUE,
	"senha"	TEXT NOT NULL,
	"nome"	TEXT NOT NULL
);
INSERT INTO usuario VALUES(1,'adm','adm','Administrador');

COMMIT;
