-- ============================================================
-- SECTION 1: BASIC LISTINGS
-- ============================================================

-- List all cities
SELECT * FROM cidades;

-- List all people
SELECT * FROM pessoas;

-- List all licenses
SELECT * FROM licenciamentos;

-- ============================================================
-- SECTION 2: FILTERING AND SORTING
-- ============================================================

-- List people ordered by name
SELECT * FROM pessoas ORDER BY nome ASC;

-- Search people whose name contains 'a'
SELECT * FROM pessoas WHERE nome LIKE '%a%';

-- List people born between 1990 and 2000
SELECT * FROM pessoas WHERE data_nascimento BETWEEN '1990-01-01' AND '2000-12-31';

-- List licenses with selected statuses
SELECT * FROM licenciamentos WHERE status IN ('ativo', 'vencido');

-- List licenses issued after 2024-01-01
SELECT * FROM licenciamentos WHERE data_emissao >= '2024-01-01';

-- ============================================================
-- SECTION 3: JOINS — RELATIONAL REPORTS
-- ============================================================

-- Show people with their city of residence
SELECT
    pessoas.id_pessoa,
    pessoas.nome,
    pessoas.cpf,
    cidades.nome        AS cidade_residencia,
    cidades.estado
FROM pessoas
INNER JOIN cidades
    ON pessoas.id_cidade_residencia = cidades.id_cidade;

-- Show licenses with person and city information
SELECT
    licenciamentos.id_licenciamento,
    pessoas.nome        AS pessoa,
    cidades.nome        AS cidade_licenciamento,
    licenciamentos.atividade,
    licenciamentos.data_emissao,
    licenciamentos.data_validade,
    licenciamentos.status
FROM licenciamentos
INNER JOIN pessoas
    ON licenciamentos.id_pessoa = pessoas.id_pessoa
INNER JOIN cidades
    ON licenciamentos.id_cidade = cidades.id_cidade;

-- Show all people and their licenses, including people without licenses
SELECT
    pessoas.id_pessoa,
    pessoas.nome,
    licenciamentos.id_licenciamento,
    licenciamentos.atividade,
    licenciamentos.status
FROM pessoas
LEFT JOIN licenciamentos
    ON pessoas.id_pessoa = licenciamentos.id_pessoa;

-- Show all licenses and related people using RIGHT JOIN
SELECT
    pessoas.nome        AS pessoa,
    licenciamentos.id_licenciamento,
    licenciamentos.atividade,
    licenciamentos.status
FROM pessoas
RIGHT JOIN licenciamentos
    ON pessoas.id_pessoa = licenciamentos.id_pessoa;

-- ============================================================
-- SECTION 4: AGGREGATION AND GROUPING
-- ============================================================

-- Count licenses by status
SELECT
    status,
    COUNT(*)            AS total_licenciamentos
FROM licenciamentos
GROUP BY status;

-- Count licenses by city
SELECT
    cidades.nome        AS cidade,
    cidades.estado,
    COUNT(licenciamentos.id_licenciamento) AS total_licenciamentos
FROM cidades
LEFT JOIN licenciamentos
    ON cidades.id_cidade = licenciamentos.id_cidade
GROUP BY cidades.nome, cidades.estado;

-- Show cities with more than one license
SELECT
    cidades.nome        AS cidade,
    cidades.estado,
    COUNT(licenciamentos.id_licenciamento) AS total_licenciamentos
FROM cidades
INNER JOIN licenciamentos
    ON cidades.id_cidade = licenciamentos.id_cidade
GROUP BY cidades.nome, cidades.estado
HAVING COUNT(licenciamentos.id_licenciamento) > 1;