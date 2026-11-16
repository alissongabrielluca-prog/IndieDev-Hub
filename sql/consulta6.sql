--- Objetivo: identificar versoes com testes obrigatorios reprovados.
--- HAVING filtra as versoes cuja soma de testes obrigatorios reprovados e maior que zero.
SELECT v.id_versao, v.identificacao,
       SUM(CASE WHEN t.obrigatorio = 1 AND t.resultado = 'Reprovado' THEN 1 ELSE 0 END) AS testes_reprovados
FROM VERSAO v
INNER JOIN TESTE t ON t.id_versao = v.id_versao
GROUP BY v.id_versao, v.identificacao
HAVING SUM(CASE WHEN t.obrigatorio = 1 AND t.resultado = 'Reprovado' THEN 1 ELSE 0 END) > 0;
