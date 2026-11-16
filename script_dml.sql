-- ============================================================
-- IndieDev Hub
-- Projeto Final - Bancos de Dados e Aplicacoes
-- Script DML - SQLite
-- Dados ficticios para demonstracao e validacao do banco.
-- Execute depois do script_ddl.sql.
-- ============================================================

PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

-- 1. USUARIO
INSERT INTO USUARIO (id_usuario, nome, email) VALUES
(1, 'Ana Souza', 'ana.souza@indiedev.com'),
(2, 'Bruno Lima', 'bruno.lima@indiedev.com'),
(3, 'Carla Mendes', 'carla.mendes@indiedev.com'),
(4, 'Diego Alves', 'diego.alves@indiedev.com'),
(5, 'Eduarda Costa', 'eduarda.costa@indiedev.com'),
(6, 'Felipe Rocha', 'felipe.rocha@indiedev.com');

-- 2. EQUIPE
INSERT INTO EQUIPE (id_equipe, nome) VALUES
(1, 'Pixel Forge'),
(2, 'Nebula Studio'),
(3, 'Aurora Games');

-- 3. MEMBRO_EQUIPE
INSERT INTO MEMBRO_EQUIPE (id_membro, id_usuario, id_equipe, funcao) VALUES
(1, 1, 1, 'Gerente de projeto'),
(2, 2, 1, 'Programador'),
(3, 3, 1, 'Artista'),
(4, 4, 2, 'Designer de jogos'),
(5, 5, 2, 'Testadora QA'),
(6, 6, 2, 'Programador'),
(7, 1, 3, 'Publicadora');

-- 4. PROJETO
INSERT INTO PROJETO (id_projeto, id_equipe, nome, descricao) VALUES
(1, 1, 'Lendas de Aster', 'RPG de aventura em um mundo de fantasia.'),
(2, 1, 'Circuito Zero', 'Jogo de corrida futurista independente.'),
(3, 2, 'Misterios da Nebula', 'Aventura narrativa com exploracao espacial.'),
(4, 3, 'Jardim das Estrelas', 'Jogo casual de construcao e descoberta.');

-- 5. CATEGORIA_TAREFA
INSERT INTO CATEGORIA_TAREFA (id_categoria, nome, descricao) VALUES
(1, 'Programacao', 'Implementacao de funcionalidades e sistemas.'),
(2, 'Arte', 'Criacao de personagens, cenarios e elementos visuais.'),
(3, 'Design', 'Mecanicas, balanceamento e experiencia de jogo.'),
(4, 'Testes', 'Verificacao de qualidade e identificacao de falhas.'),
(5, 'Documentacao', 'Documentacao tecnica e de projeto.');

-- 6. TAREFA
INSERT INTO TAREFA
(id_tarefa, id_projeto, id_categoria, id_responsavel, titulo, descricao, status) VALUES
(1, 1, 1, 2, 'Implementar sistema de combate', 'Criar ataques, defesa e calculo de dano.', 'Concluida'),
(2, 1, 2, 3, 'Desenhar personagem principal', 'Finalizar conceito e sprites do protagonista.', 'Em andamento'),
(3, 1, 4, 1, 'Testar sistema de combate', 'Executar testes funcionais do combate.', 'Pendente'),
(4, 2, 1, 2, 'Criar controle dos veiculos', 'Implementar aceleracao, frenagem e direcao.', 'Em andamento'),
(5, 2, 3, NULL, 'Balancear pistas', 'Ajustar dificuldade e distribuicao de obstaculos.', 'Pendente'),
(6, 3, 1, 6, 'Implementar dialogos', 'Criar sistema de dialogos ramificados.', 'Concluida'),
(7, 3, 4, 5, 'Validar escolhas narrativas', 'Verificar os caminhos e finais da historia.', 'Em andamento'),
(8, 4, 2, 7, 'Criar conjunto de itens', 'Desenhar itens colecionaveis do jogo.', 'Pendente');

-- 7. MARCO
INSERT INTO MARCO (id_marco, id_projeto, nome, descricao, data_prevista) VALUES
(1, 1, 'Prototipo jogavel', 'Combate e movimentacao funcionais.', '2026-10-30'),
(2, 1, 'Versao beta', 'Conteudo principal pronto para testes.', '2026-12-10'),
(3, 2, 'Demo publica', 'Primeira demonstracao jogavel.', '2026-11-25'),
(4, 3, 'Roteiro finalizado', 'Dialogos e finais revisados.', '2026-12-05'),
(5, 4, 'Acesso antecipado', 'Primeira versao disponibilizada.', '2027-01-20');

-- 8. VERSAO
INSERT INTO VERSAO (id_versao, id_projeto, identificacao, data_criacao) VALUES
(1, 1, '0.9.0', '2026-10-20'),
(2, 1, '1.0.0', '2026-11-05'),
(3, 2, '0.5.0', '2026-10-28'),
(4, 3, '0.8.0', '2026-11-08'),
(5, 4, '0.2.0', '2026-11-12');

-- 9. BUG
INSERT INTO BUG
(id_bug, id_projeto, id_versao, descricao, status, descricao_correcao) VALUES
(1, 1, 1, 'Personagem atravessa a parede na fase inicial.', 'Corrigido', 'Colisao da parede ajustada.'),
(2, 1, 2, 'Efeito visual do ataque aparece fora de posicao.', 'Aberto', NULL),
(3, 2, 3, 'Veiculo perde velocidade ao cruzar a linha de chegada.', 'Em analise', NULL),
(4, 3, 4, 'Dialogo opcional nao aparece apos carregar o jogo.', 'Corrigido', 'Condicao de exibicao do dialogo corrigida.'),
(5, 4, NULL, 'Texto de um item apresenta erro de digitacao.', 'Aberto', NULL);

-- 10. TESTE
-- Todos os executores pertencem a equipe responsavel pelo projeto da versao.
INSERT INTO TESTE
(id_teste, id_versao, id_membro, descricao, resultado, data_teste, obrigatorio) VALUES
(1, 1, 1, 'Teste de movimentacao do personagem', 'Aprovado', '2026-10-21', 1),
(2, 1, 2, 'Teste de combate basico', 'Aprovado', '2026-10-22', 1),
(3, 2, 3, 'Teste de efeitos visuais', 'Pendente', '2026-11-06', 0),
(4, 3, 2, 'Teste de aceleracao dos veiculos', 'Aprovado', '2026-10-29', 1),
(5, 3, 1, 'Teste de desempenho em pista', 'Reprovado', '2026-10-30', 0),
(6, 4, 5, 'Teste de dialogos principais', 'Aprovado', '2026-11-09', 1),
(7, 4, 6, 'Teste de caminhos alternativos', 'Pendente', '2026-11-10', 1),
(8, 5, 7, 'Teste de interface inicial', 'Aprovado', '2026-11-13', 1);

-- 11. COMENTARIO
-- Cada comentario esta associado a uma tarefa OU a um bug.
INSERT INTO COMENTARIO
(id_comentario, id_usuario, id_tarefa, id_bug, conteudo, data_hora) VALUES
(1, 1, 1, NULL, 'Implementacao aprovada para a primeira versao.', '2026-10-23 10:30:00'),
(2, 3, 2, NULL, 'Enviei uma nova proposta visual para revisao.', '2026-10-24 14:15:00'),
(3, 2, NULL, 1, 'A correcao de colisao foi aplicada e verificada.', '2026-10-25 09:00:00'),
(4, 4, 4, NULL, 'O controle precisa de mais um ajuste na frenagem.', '2026-10-29 16:20:00'),
(5, 5, NULL, 3, 'Consegui reproduzir o problema na linha de chegada.', '2026-10-31 11:45:00'),
(6, 6, 6, NULL, 'Sistema de dialogos integrado ao projeto.', '2026-11-10 13:10:00'),
(7, 1, NULL, 4, 'Correcao validada durante a revisao narrativa.', '2026-11-11 08:50:00'),
(8, 5, 7, NULL, 'Ainda falta verificar um dos finais alternativos.', '2026-11-12 17:00:00');

-- 12. PUBLICACAO
-- Nenhuma versao publicada possui teste obrigatorio reprovado.
INSERT INTO PUBLICACAO
(id_publicacao, id_versao, plataforma, data_publicacao) VALUES
(1, 1, 'itch.io', '2026-10-26'),
(2, 3, 'Steam', '2026-11-02'),
(3, 4, 'itch.io', '2026-11-14'),
(4, 5, 'Google Play', '2026-11-15');

COMMIT;

-- ============================================================
-- FIM DO SCRIPT DML
-- ============================================================
