--- Objetivo: demonstrar controle transacional com SAVEPOINT, ROLLBACK TO, RELEASE, COMMIT e ROLLBACK.
--- A primeira transacao confirma uma alteracao; a segunda desfaz integralmente uma alteracao de teste.
PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;
UPDATE TAREFA
SET descricao = 'Descricao revisada e confirmada.'
WHERE id_tarefa = 1;

SAVEPOINT ajuste_secundario;
UPDATE TAREFA
SET descricao = 'Alteracao temporaria que sera desfeita.'
WHERE id_tarefa = 2;

ROLLBACK TO SAVEPOINT ajuste_secundario;
RELEASE SAVEPOINT ajuste_secundario;
COMMIT;

BEGIN TRANSACTION;
UPDATE TESTE
SET descricao = 'Alteracao temporaria para demonstrar ROLLBACK.'
WHERE id_teste = 1;
ROLLBACK;
