--- Objetivo: listar equipes que possuem pelo menos dois projetos cadastrados.
--- Utiliza COUNT, GROUP BY e HAVING para filtrar grupos.
SELECT e.id_equipe, e.nome AS equipe, COUNT(p.id_projeto) AS total_projetos
FROM EQUIPE e
INNER JOIN PROJETO p ON p.id_equipe = e.id_equipe
GROUP BY e.id_equipe, e.nome
HAVING COUNT(p.id_projeto) >= 2;
