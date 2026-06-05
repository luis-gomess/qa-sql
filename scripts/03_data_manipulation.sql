-- Insert cities
INSERT INTO cidades (id_cidade, nome, estado) VALUES
(1, 'Sao Paulo',      'SP'),
(2, 'Rio de Janeiro', 'RJ'),
(3, 'Belo Horizonte', 'MG'),
(4, 'Curitiba',       'PR'),
(5, 'Fortaleza',      'CE'),
(6, 'Manaus',         'AM');

-- Insert people
INSERT INTO pessoas (id_pessoa, nome, cpf, data_nascimento, id_cidade_residencia) VALUES
(1, 'Ana Silva',     '12345678901', '1995-03-15', 1),
(2, 'Carlos Souza',  '23456789012', '1988-07-21', 2),
(3, 'Mariana Costa', '34567890123', '1992-11-10', 3),
(4, 'Joao Pereira',  '45678901234', '1985-01-30', 4),
(5, 'Fernanda Lima', '56789012345', '1998-09-05', 5),
(6, 'Roberto Alves', '67890123456', '1990-06-18', 1);

-- Insert licenses
INSERT INTO licenciamentos (id_licenciamento, id_pessoa, id_cidade, atividade, data_emissao, data_validade, status) VALUES
(1, 1, 1, 'Food Truck',      '2025-06-01', '2026-06-01', 'ativo'),
(2, 2, 2, 'Street Vendor',   '2023-05-15', '2024-05-15', 'vencido'),
(3, 3, 3, 'Taxi Service',    '2024-02-20', '2025-02-20', 'vencido'),
(4, 4, 4, 'Parking Service', '2022-08-01', '2023-08-01', 'revogado'),
(5, 5, 5, 'Tour Guide',      '2025-08-01', '2026-08-01', 'ativo'),
(6, 1, 1, 'Event Organizer', '2025-07-01', '2026-07-01', 'ativo');

-- ⚠️ The UPDATE and DELETE examples below are NOT used in the validation tests.
-- They are kept here as DML reference and can be run manually if needed.
-- Executing them will modify the seed data and may affect CT results.

-- Update person's city of residence
-- UPDATE pessoas SET id_cidade_residencia = 2 WHERE id_pessoa = 1;

-- Update license status
-- UPDATE licenciamentos SET status = 'vencido' WHERE id_licenciamento = 1;

-- Renew a license by extending its validity
-- UPDATE licenciamentos SET data_validade = DATE_ADD(data_validade, INTERVAL 1 YEAR) WHERE id_licenciamento = 3;

-- Delete a specific license
-- DELETE FROM licenciamentos WHERE id_licenciamento = 4;

-- Delete all expired licenses
-- DELETE FROM licenciamentos WHERE status = 'vencido';

-- Delete a person with no licenses
-- DELETE FROM pessoas WHERE id_pessoa = 6;