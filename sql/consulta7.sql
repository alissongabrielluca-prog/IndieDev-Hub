--- Objetivo: listar projetos que possuem bugs registrados e cuja quantidade de bugs supera a media por projeto.
--- Contem subconsulta escalar (media de bugs) e subconsulta com IN.
SELECT p.id_projeto, p.nome
FROM PROJETO p
WHERE p.id_projeto IN (
    SELECT b.id_projeto
    FROM BUG b
    GROUP BY b.id_projeto
    HAVING COUNT(*) > (
        SELECT AVG(total_bugs)
        FROM (
            SELECT COUNT(*) AS total_bugs
            FROM BUG
            GROUP BY id_projeto
        ) AS medias
    )
);
