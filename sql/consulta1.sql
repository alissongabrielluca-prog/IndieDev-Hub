--- Objetivo: contar tarefas por equipe, mostrando apenas equipes com tarefas.
--- Utiliza INNER JOIN entre EQUIPE, PROJETO e TAREFA, agrupamento e ordem crescente.
SELECT e.id_equipe, e.nome AS equipe, COUNT(t.id_tarefa) AS total_tarefas
FROM EQUIPE e
INNER JOIN PROJETO p ON p.id_equipe = e.id_equipe
INNER JOIN TAREFA t ON t.id_projeto = p.id_projeto
GROUP BY e.id_equipe, e.nome
ORDER BY total_tarefas ASC;
