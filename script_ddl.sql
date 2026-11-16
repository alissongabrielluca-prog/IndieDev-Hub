-- ============================================================
-- IndieDev Hub
-- Projeto Final - Bancos de Dados e Aplicacoes
-- Script DDL - SQLite
-- ============================================================

PRAGMA foreign_keys = ON;

-- Remove objetos existentes para permitir executar o script novamente.
DROP TRIGGER IF EXISTS trg_tarefa_responsavel_insert;
DROP TRIGGER IF EXISTS trg_tarefa_responsavel_update;
DROP TRIGGER IF EXISTS trg_teste_executor_insert;
DROP TRIGGER IF EXISTS trg_teste_executor_update;
DROP TRIGGER IF EXISTS trg_publicacao_testes_reprovados;
DROP TRIGGER IF EXISTS trg_teste_reprovado_apos_publicacao_insert;
DROP TRIGGER IF EXISTS trg_teste_reprovado_apos_publicacao_update;
DROP TRIGGER IF EXISTS trg_bug_correcao_insert;
DROP TRIGGER IF EXISTS trg_bug_correcao_update;
DROP TRIGGER IF EXISTS trg_tarefa_nao_volta_pendente;

DROP TABLE IF EXISTS PUBLICACAO;
DROP TABLE IF EXISTS COMENTARIO;
DROP TABLE IF EXISTS TESTE;
DROP TABLE IF EXISTS BUG;
DROP TABLE IF EXISTS VERSAO;
DROP TABLE IF EXISTS MARCO;
DROP TABLE IF EXISTS TAREFA;
DROP TABLE IF EXISTS CATEGORIA_TAREFA;
DROP TABLE IF EXISTS PROJETO;
DROP TABLE IF EXISTS MEMBRO_EQUIPE;
DROP TABLE IF EXISTS EQUIPE;
DROP TABLE IF EXISTS USUARIO;

-- 1. USUARIO
CREATE TABLE USUARIO (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome       TEXT NOT NULL CHECK (length(trim(nome)) > 0),
    email      TEXT NOT NULL UNIQUE CHECK (length(trim(email)) > 0)
);

-- 2. EQUIPE
CREATE TABLE EQUIPE (
    id_equipe INTEGER PRIMARY KEY AUTOINCREMENT,
    nome      TEXT NOT NULL UNIQUE CHECK (length(trim(nome)) > 0)
);

-- 3. MEMBRO_EQUIPE: associacao entre usuario e equipe
CREATE TABLE MEMBRO_EQUIPE (
    id_membro  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_equipe  INTEGER NOT NULL,
    funcao     TEXT NOT NULL CHECK (length(trim(funcao)) > 0),
    CONSTRAINT uq_membro_usuario_equipe UNIQUE (id_usuario, id_equipe),
    CONSTRAINT uq_membro_id_equipe UNIQUE (id_membro, id_equipe),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 4. PROJETO
CREATE TABLE PROJETO (
    id_projeto INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipe  INTEGER NOT NULL,
    nome       TEXT NOT NULL CHECK (length(trim(nome)) > 0),
    descricao  TEXT,
    CONSTRAINT uq_projeto_id_equipe UNIQUE (id_projeto, id_equipe),
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 5. CATEGORIA_TAREFA
CREATE TABLE CATEGORIA_TAREFA (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome         TEXT NOT NULL UNIQUE CHECK (length(trim(nome)) > 0),
    descricao    TEXT
);

-- 6. TAREFA
CREATE TABLE TAREFA (
    id_tarefa      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_projeto     INTEGER NOT NULL,
    id_categoria   INTEGER NOT NULL,
    id_responsavel INTEGER,
    titulo         TEXT NOT NULL CHECK (length(trim(titulo)) > 0),
    descricao      TEXT,
    status         TEXT NOT NULL DEFAULT 'Pendente'
                   CHECK (status IN ('Pendente', 'Em andamento', 'Concluida', 'Cancelada')),
    FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_TAREFA(id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_responsavel) REFERENCES MEMBRO_EQUIPE(id_membro)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- 7. MARCO
CREATE TABLE MARCO (
    id_marco      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_projeto    INTEGER NOT NULL,
    nome          TEXT NOT NULL CHECK (length(trim(nome)) > 0),
    descricao     TEXT,
    data_prevista TEXT,
    FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 8. VERSAO
CREATE TABLE VERSAO (
    id_versao     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_projeto    INTEGER NOT NULL,
    identificacao TEXT NOT NULL CHECK (length(trim(identificacao)) > 0),
    data_criacao  TEXT NOT NULL DEFAULT (date('now')),
    CONSTRAINT uq_versao_projeto_identificacao UNIQUE (id_projeto, identificacao),
    CONSTRAINT uq_versao_id_projeto UNIQUE (id_versao, id_projeto),
    FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 9. BUG: a FK composta garante que a versao seja do mesmo projeto.
CREATE TABLE BUG (
    id_bug             INTEGER PRIMARY KEY AUTOINCREMENT,
    id_projeto         INTEGER NOT NULL,
    id_versao          INTEGER,
    descricao          TEXT NOT NULL CHECK (length(trim(descricao)) > 0),
    status             TEXT NOT NULL DEFAULT 'Aberto'
                       CHECK (status IN ('Aberto', 'Em analise', 'Corrigido', 'Fechado')),
    descricao_correcao TEXT,
    FOREIGN KEY (id_projeto) REFERENCES PROJETO(id_projeto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_versao, id_projeto)
        REFERENCES VERSAO(id_versao, id_projeto)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK (status <> 'Corrigido' OR
           (descricao_correcao IS NOT NULL AND length(trim(descricao_correcao)) > 0))
);

-- 10. TESTE
-- obrigatorio = 1: teste cuja reprovacao impede a publicacao da versao.
CREATE TABLE TESTE (
    id_teste    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_versao   INTEGER NOT NULL,
    id_membro   INTEGER NOT NULL,
    descricao   TEXT NOT NULL CHECK (length(trim(descricao)) > 0),
    resultado   TEXT NOT NULL DEFAULT 'Pendente'
                CHECK (resultado IN ('Aprovado', 'Reprovado', 'Pendente')),
    data_teste  TEXT NOT NULL DEFAULT (date('now')),
    obrigatorio INTEGER NOT NULL DEFAULT 1 CHECK (obrigatorio IN (0, 1)),
    FOREIGN KEY (id_versao) REFERENCES VERSAO(id_versao)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_membro) REFERENCES MEMBRO_EQUIPE(id_membro)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 11. COMENTARIO: deve apontar para tarefa OU bug, nunca ambos.
CREATE TABLE COMENTARIO (
    id_comentario INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario    INTEGER NOT NULL,
    id_tarefa     INTEGER,
    id_bug        INTEGER,
    conteudo      TEXT NOT NULL CHECK (length(trim(conteudo)) > 0),
    data_hora     TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_tarefa) REFERENCES TAREFA(id_tarefa)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_bug) REFERENCES BUG(id_bug)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK ((id_tarefa IS NOT NULL AND id_bug IS NULL) OR
           (id_tarefa IS NULL AND id_bug IS NOT NULL))
);

-- 12. PUBLICACAO
CREATE TABLE PUBLICACAO (
    id_publicacao   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_versao       INTEGER NOT NULL,
    plataforma      TEXT NOT NULL CHECK (length(trim(plataforma)) > 0),
    data_publicacao TEXT NOT NULL DEFAULT (date('now')),
    FOREIGN KEY (id_versao) REFERENCES VERSAO(id_versao)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ============================================================
-- TRIGGERS: regras de negocio complementares
-- ============================================================

-- O responsavel da tarefa deve pertencer a equipe do projeto.
CREATE TRIGGER trg_tarefa_responsavel_insert
BEFORE INSERT ON TAREFA
WHEN NEW.id_responsavel IS NOT NULL
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1
        FROM MEMBRO_EQUIPE me
        JOIN PROJETO p ON p.id_equipe = me.id_equipe
        WHERE me.id_membro = NEW.id_responsavel
          AND p.id_projeto = NEW.id_projeto
    ) THEN RAISE(ABORT, 'O responsavel deve pertencer a equipe do projeto.') END;
END;

CREATE TRIGGER trg_tarefa_responsavel_update
BEFORE UPDATE OF id_responsavel, id_projeto ON TAREFA
WHEN NEW.id_responsavel IS NOT NULL
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1
        FROM MEMBRO_EQUIPE me
        JOIN PROJETO p ON p.id_equipe = me.id_equipe
        WHERE me.id_membro = NEW.id_responsavel
          AND p.id_projeto = NEW.id_projeto
    ) THEN RAISE(ABORT, 'O responsavel deve pertencer a equipe do projeto.') END;
END;

-- O executor do teste deve pertencer a equipe responsavel pelo projeto da versao.
CREATE TRIGGER trg_teste_executor_insert
BEFORE INSERT ON TESTE
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1
        FROM VERSAO v
        JOIN PROJETO p ON p.id_projeto = v.id_projeto
        JOIN MEMBRO_EQUIPE me ON me.id_equipe = p.id_equipe
        WHERE v.id_versao = NEW.id_versao
          AND me.id_membro = NEW.id_membro
    ) THEN RAISE(ABORT, 'O executor deve pertencer a equipe do projeto da versao.') END;
END;

CREATE TRIGGER trg_teste_executor_update
BEFORE UPDATE OF id_versao, id_membro ON TESTE
BEGIN
    SELECT CASE WHEN NOT EXISTS (
        SELECT 1
        FROM VERSAO v
        JOIN PROJETO p ON p.id_projeto = v.id_projeto
        JOIN MEMBRO_EQUIPE me ON me.id_equipe = p.id_equipe
        WHERE v.id_versao = NEW.id_versao
          AND me.id_membro = NEW.id_membro
    ) THEN RAISE(ABORT, 'O executor deve pertencer a equipe do projeto da versao.') END;
END;

-- Bloqueia a publicacao se ja existir teste obrigatorio reprovado.
CREATE TRIGGER trg_publicacao_testes_reprovados
BEFORE INSERT ON PUBLICACAO
BEGIN
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM TESTE t
        WHERE t.id_versao = NEW.id_versao
          AND t.obrigatorio = 1
          AND t.resultado = 'Reprovado'
    ) THEN RAISE(ABORT, 'Publicacao bloqueada: existe teste obrigatorio reprovado.') END;
END;

-- Impede que um teste obrigatorio seja reprovado depois da publicacao.
CREATE TRIGGER trg_teste_reprovado_apos_publicacao_insert
BEFORE INSERT ON TESTE
WHEN NEW.obrigatorio = 1 AND NEW.resultado = 'Reprovado'
BEGIN
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM PUBLICACAO pub WHERE pub.id_versao = NEW.id_versao
    ) THEN RAISE(ABORT, 'A versao ja foi publicada; nao e permitido inserir teste obrigatorio reprovado.') END;
END;

CREATE TRIGGER trg_teste_reprovado_apos_publicacao_update
BEFORE UPDATE OF resultado, obrigatorio, id_versao ON TESTE
WHEN NEW.obrigatorio = 1 AND NEW.resultado = 'Reprovado'
BEGIN
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM PUBLICACAO pub WHERE pub.id_versao = NEW.id_versao
    ) THEN RAISE(ABORT, 'A versao ja foi publicada; nao e permitido reprovar teste obrigatorio.') END;
END;

-- Um bug so pode ser marcado como Corrigido com descricao da correcao.
CREATE TRIGGER trg_bug_correcao_insert
BEFORE INSERT ON BUG
WHEN NEW.status = 'Corrigido'
 AND (NEW.descricao_correcao IS NULL OR length(trim(NEW.descricao_correcao)) = 0)
BEGIN
    SELECT RAISE(ABORT, 'Informe a descricao da correcao antes de concluir o bug.');
END;

CREATE TRIGGER trg_bug_correcao_update
BEFORE UPDATE OF status, descricao_correcao ON BUG
WHEN NEW.status = 'Corrigido'
 AND (NEW.descricao_correcao IS NULL OR length(trim(NEW.descricao_correcao)) = 0)
BEGIN
    SELECT RAISE(ABORT, 'Informe a descricao da correcao antes de concluir o bug.');
END;

-- Uma tarefa concluida nao pode voltar diretamente para Pendente.
CREATE TRIGGER trg_tarefa_nao_volta_pendente
BEFORE UPDATE OF status ON TAREFA
WHEN OLD.status = 'Concluida' AND NEW.status = 'Pendente'
BEGIN
    SELECT RAISE(ABORT, 'Tarefa concluida nao pode voltar diretamente para Pendente.');
END;

-- ============================================================
-- FIM DO SCRIPT DDL
-- ============================================================
