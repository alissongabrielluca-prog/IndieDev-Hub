--- Objetivo: calcular a media de tarefas por projeto.
--- A subconsulta calcula a quantidade de tarefas de cada projeto; AVG calcula a media geral.
SELECT AVG(total_tarefas) AS media_tarefas_por_projeto
FROM (
    SELECT p.id_projeto, COUNT(t.id_tarefa) AS total_tarefas
    FROM PROJETO p
    LEFT JOIN TAREFA t ON t.id_projeto = p.id_projeto
    GROUP BY p.id_projeto
) AS tarefas_por_projeto;
