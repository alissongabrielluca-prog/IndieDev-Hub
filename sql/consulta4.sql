--- Objetivo: identificar as datas da versao mais antiga e da mais recente de cada projeto.
--- MIN e MAX operam sobre datas armazenadas no formato ISO YYYY-MM-DD.
SELECT p.id_projeto, p.nome AS projeto,
       MIN(v.data_criacao) AS primeira_versao,
       MAX(v.data_criacao) AS versao_mais_recente
FROM PROJETO p
INNER JOIN VERSAO v ON v.id_projeto = p.id_projeto
GROUP BY p.id_projeto, p.nome;
