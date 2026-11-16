--- Objetivo: listar equipes que possuem ao menos um projeto com tarefa pendente.
--- Utiliza subconsulta correlacionada com EXISTS.
SELECT e.id_equipe, e.nome AS equipe
FROM EQUIPE e
WHERE EXISTS (
    SELECT 1
    FROM PROJETO p
    INNER JOIN TAREFA t ON t.id_projeto = p.id_projeto
    WHERE p.id_equipe = e.id_equipe
      AND t.status = 'Pendente'
);
