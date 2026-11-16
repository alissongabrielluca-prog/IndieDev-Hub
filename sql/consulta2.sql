--- Objetivo: contar quantos testes obrigatorios existem por versao.
--- SUM agrega o indicador obrigatorio (1 = sim, 0 = nao).
SELECT v.id_versao, v.identificacao,
       SUM(t.obrigatorio) AS total_testes_obrigatorios
FROM VERSAO v
LEFT JOIN TESTE t ON t.id_versao = v.id_versao
GROUP BY v.id_versao, v.identificacao
ORDER BY total_testes_obrigatorios DESC;
