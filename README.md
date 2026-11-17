# IndieDev Hub

**Plataforma de gerenciamento de projetos de desenvolvimento de jogos independentes.**

Projeto final da disciplina **CIN 8003 – Bancos de Dados e Aplicações**, da Universidade Federal de Santa Catarina (UFSC).

## 1. Sobre o projeto

O IndieDev Hub é uma proposta de sistema para auxiliar equipes independentes no gerenciamento e acompanhamento do desenvolvimento de jogos.

A plataforma permite organizar equipes, participantes, projetos, tarefas, marcos, versões, bugs, testes, comentários e publicações, centralizando informações importantes durante o processo de desenvolvimento.

## 2. Funcionalidades contempladas

- Cadastro e gerenciamento de usuários e equipes.
- Organização de projetos e participantes.
- Gerenciamento de tarefas e categorias.
- Acompanhamento de marcos e versões.
- Registro e acompanhamento de bugs.
- Gerenciamento de testes e seus resultados.
- Registro de comentários.
- Controle de publicações de versões.

## 3. Estrutura do repositório

```text
IndieDev-Hub/
│
├── documentos/
│   ├── IndieDev_Hub_Modelo_de_Requisitos.docx
│   ├── IndieDev_Hub_Modelo_Logico.pdf
│   └── README.md
│
├── diagramas/
│   ├── Diagrama em PNG
│   ├── Diagrama em SVG
│   ├── Código-fonte Mermaid (.mmd)
│   ├── Diagrama em PDF
│   └── README.md
│
├── sql/
│   ├── consulta1.sql
│   ├── consulta2.sql
│   ├── consulta3.sql
│   ├── consulta4.sql
│   ├── consulta5.sql
│   ├── consulta6.sql
│   ├── consulta7.sql
│   ├── consulta8.sql
│   ├── consulta9.sql
│   ├── consulta10.sql
│   └── README.md
│
├── script_ddl.sql
├── script_dml.sql
├── indiedev_hub.db
└── README.md
```

## 4. Banco de dados

O projeto utiliza SQLite para armazenamento e gerenciamento dos dados.

O banco é composto por 12 tabelas:

1. USUARIO
2. EQUIPE
3. MEMBRO_EQUIPE
4. PROJETO
5. CATEGORIA_TAREFA
6. TAREFA
7. MARCO
8. VERSAO
9. BUG
10. TESTE
11. COMENTARIO
12. PUBLICACAO

O arquivo `script_ddl.sql` contém a definição das tabelas, chaves, restrições de integridade e triggers.

O arquivo `script_dml.sql` contém os comandos para inserção dos dados iniciais.

O arquivo `indiedev_hub.db` contém o banco de dados SQLite.

## 5. Consultas SQL

O projeto apresenta dez consultas SQL individuais, contemplando funções agregadas, junções, subconsultas, agrupamentos, CTE, tratamento de valores nulos e controle de transações.

As consultas estão disponíveis na pasta `sql/`.

## 6. Tecnologias e ferramentas

- **SQLite:** sistema gerenciador de banco de dados.
- **DB Browser for SQLite:** ferramenta para execução e validação das consultas.
- **Mermaid:** criação e representação dos diagramas.
- **GitHub:** versionamento e organização dos arquivos do projeto.

## 7. Informações acadêmicas

**Projeto:** IndieDev Hub  
**Disciplina:** CIN 8003 – Bancos de Dados e Aplicações  
**Instituição:** Universidade Federal de Santa Catarina (UFSC)  
**Modalidade:** Projeto Final Individual

---
