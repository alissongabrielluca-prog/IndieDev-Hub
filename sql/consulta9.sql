--- Objetivo: apresentar todos os projetos e suas quantidades de bugs e tarefas.
--- Usa CTE, LEFT JOIN e COALESCE para substituir valores nulos por zero.
WITH resumo_bugs AS (
    SELECT id_projeto, COUNT(*) AS total_bugs
    FROM BUG
    GROUP BY id_projeto
),
resumo_tarefas AS (
    SELECT id_projeto, COUNT(*) AS total_tarefas
    FROM TAREFA
    GROUP BY id_projeto
)
SELECT p.id_projeto, p.nome AS projeto,
       COALESCE(rb.total_bugs, 0) AS total_bugs,
       COALESCE(rt.total_tarefas, 0) AS total_tarefas
FROM PROJETO p
LEFT JOIN resumo_bugs rb ON rb.id_projeto = p.id_projeto
LEFT JOIN resumo_tarefas rt ON rt.id_projeto = p.id_projeto
ORDER BY p.nome ASC;
