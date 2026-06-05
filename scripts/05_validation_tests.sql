-- ============================================================
-- CT-01 | Expired licenses
-- Expected: Return expired licenses
-- Why: Licenses with status 'vencido' OR past their validity
--      date must be identifiable for renewal or archiving.
-- ============================================================
SELECT
    id_licenciamento,
    id_pessoa,
    id_cidade,
    atividade,
    data_emissao,
    data_validade,
    status
FROM licenciamentos
WHERE status = 'vencido'
   OR data_validade < CURRENT_DATE;

-- ============================================================
-- CT-02 | Active licenses with expired validity date
-- Expected: No records returned
-- Why: A license marked 'ativo' must never have a past
--      expiration date — this would indicate a data inconsistency.
-- ============================================================
SELECT
    id_licenciamento,
    atividade,
    data_validade,
    status
FROM licenciamentos
WHERE status = 'ativo'
  AND data_validade < CURRENT_DATE;

-- ============================================================
-- CT-03 | Revoked licenses
-- Expected: Return revoked licenses
-- Why: Revoked licenses must be auditable and visible for
--      compliance and administrative review.
-- ============================================================
SELECT
    id_licenciamento,
    id_pessoa,
    id_cidade,
    atividade,
    data_emissao,
    data_validade,
    status
FROM licenciamentos
WHERE status = 'revogado';

-- ============================================================
-- CT-04 | Licenses without an associated person
-- Expected: No records returned
-- Why: Every license must be linked to a valid person.
--      Orphaned licenses indicate a referential integrity failure.
-- ============================================================
SELECT
    l.id_licenciamento,
    l.id_pessoa,
    l.atividade
FROM licenciamentos l
LEFT JOIN pessoas p
    ON l.id_pessoa = p.id_pessoa
WHERE p.id_pessoa IS NULL;

-- ============================================================
-- CT-05 | Licenses without an associated city
-- Expected: No records returned
-- Why: Every license must be linked to a valid city.
--      Missing city references break geographic reporting.
-- ============================================================
SELECT
    l.id_licenciamento,
    l.id_cidade,
    l.atividade
FROM licenciamentos l
LEFT JOIN cidades c
    ON l.id_cidade = c.id_cidade
WHERE c.id_cidade IS NULL;

-- ============================================================
-- CT-06 | Duplicate CPF values
-- Expected: No records returned
-- Why: CPF is a unique national identifier. Duplicates indicate
--      data entry errors or a missing UNIQUE constraint.
-- ============================================================
SELECT
    cpf,
    COUNT(*) AS total
FROM pessoas
GROUP BY cpf
HAVING COUNT(*) > 1;

-- ============================================================
-- CT-07 | People without a city of residence
-- Expected: No records returned
-- Why: Every person must have a registered city of residence
--      for licensing jurisdiction purposes.
-- ============================================================
SELECT
    id_pessoa,
    nome,
    cpf,
    id_cidade_residencia
FROM pessoas
WHERE id_cidade_residencia IS NULL;

-- ============================================================
-- CT-08 | Invalid license status
-- Expected: No records returned
-- Why: Only predefined statuses are allowed ('ativo', 'vencido',
--      'revogado'). Any other value indicates corrupted data.
-- ============================================================
SELECT
    id_licenciamento,
    atividade,
    status
FROM licenciamentos
WHERE status NOT IN ('ativo', 'vencido', 'revogado');

-- ============================================================
-- CT-09 | License issue date greater than expiration date
-- Expected: No records returned
-- Why: A license cannot be valid before it was issued.
--      This catches logical date inconsistencies at the row level.
-- ============================================================
SELECT
    id_licenciamento,
    atividade,
    data_emissao,
    data_validade
FROM licenciamentos
WHERE data_emissao > data_validade;

-- ============================================================
-- CT-10 | Cities without registered residents
-- Expected: Return records for analysis
-- Why: Cities with no residents may indicate unused reference
--      data or pending population from another source.
-- ============================================================
SELECT
    c.id_cidade,
    c.nome,
    c.estado
FROM cidades c
LEFT JOIN pessoas p
    ON c.id_cidade = p.id_cidade_residencia
WHERE p.id_pessoa IS NULL;

-- ============================================================
-- CT-11 | People without licenses
-- Expected: Return records for analysis
-- Why: Identifies persons registered in the system who have
--      not yet obtained any license — useful for outreach.
-- ============================================================
SELECT
    p.id_pessoa,
    p.nome,
    p.cpf
FROM pessoas p
LEFT JOIN licenciamentos l
    ON p.id_pessoa = l.id_pessoa
WHERE l.id_licenciamento IS NULL;

-- ============================================================
-- CT-12 | Licenses expiring within the next 90 days
-- Expected: Return licenses for monitoring
-- Why: Proactive monitoring prevents accidental expiration.
--      Useful for automated renewal notifications.
-- ============================================================
SELECT
    id_licenciamento,
    id_pessoa,
    atividade,
    data_validade,
    status
FROM licenciamentos
WHERE data_validade BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 90 DAY)
  AND status = 'ativo'
ORDER BY data_validade ASC;

-- ============================================================
-- CT-13 | Future birth dates
-- Expected: No records returned
-- Why: A person cannot be born in the future.
--      This catches data entry errors or system clock issues.
-- ============================================================
SELECT
    id_pessoa,
    nome,
    cpf,
    data_nascimento
FROM pessoas
WHERE data_nascimento > CURRENT_DATE;

-- ============================================================
-- CT-14 | Licenses associated with inactive business status
-- Expected: Return records for analysis
-- Why: Licenses tied to 'vencido' or 'revogado' activities
--      may still be referenced in active workflows — needs review.
-- ============================================================
SELECT
    l.id_licenciamento,
    p.nome          AS pessoa,
    c.nome          AS cidade,
    l.atividade,
    l.data_emissao,
    l.data_validade,
    l.status
FROM licenciamentos l
INNER JOIN pessoas p
    ON l.id_pessoa = p.id_pessoa
INNER JOIN cidades c
    ON l.id_cidade = c.id_cidade
WHERE l.status IN ('vencido', 'revogado')
ORDER BY l.status, l.data_validade DESC;

-- ============================================================
-- CT-15 | People holding multiple licenses
-- Expected: Return records for analysis
-- Why: Multiple licenses per person may be legitimate but
--      should be reviewed to detect duplicates or fraud.
-- ============================================================
SELECT
    p.id_pessoa,
    p.nome,
    p.cpf,
    COUNT(l.id_licenciamento) AS total_licenciamentos
FROM pessoas p
INNER JOIN licenciamentos l
    ON p.id_pessoa = l.id_pessoa
GROUP BY p.id_pessoa, p.nome, p.cpf
HAVING COUNT(l.id_licenciamento) > 1
ORDER BY total_licenciamentos DESC;