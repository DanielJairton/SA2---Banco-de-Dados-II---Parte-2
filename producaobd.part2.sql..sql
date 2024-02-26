-- DROP SCHEMA producaobd;

-- Criando o banco de dados PRODUCAOBD.
CREATE DATABASE producaobd;

use producaobd

-- Criando a tabela FABRICANTE.
CREATE TABLE  Fabricante (
codfabricante SMALLINT NOT NULL,
nomefabricante VARCHAR(30) NOT NULL,
PRIMARY KEY (codfabricante));

-- Criando a tabela PRODUTO.
CREATE TABLE  Produto (
codproduto INT NOT NULL,
nomeproduto VARCHAR(30) NOT NULL,
codfabricante SMALLINT NOT NULL,
PRIMARY KEY (codproduto),
CONSTRAINT fk_Produto_Fabricante
FOREIGN KEY (codfabricante)
REFERENCES Fabricante (codfabricante));

-- Criando a tabela LOTE.
CREATE TABLE Lote (
numlote INT NOT NULL,
datavalidade DATE NOT NULL,
precounitario DECIMAL(10,2),
quantidade SMALLINT NOT NULL DEFAULT 100,
valorlote DECIMAL(10,2),
codproduto INT NOT NULL,
PRIMARY KEY (numlote),
CONSTRAINT fk_Lote_Produto
FOREIGN KEY (codproduto)
REFERENCES Produto (codproduto));

-- Inserindo registros na tabela FABRICANTE.
INSERT INTO Fabricante VALUES (1, 'Clear');
INSERT INTO Fabricante VALUES (2, 'Rexona');
INSERT INTO Fabricante VALUES (3, 'Jhonson & Jhonson');
INSERT INTO Fabricante VALUES (4, 'Coleston');

-- Inserindo registros na tabela PRODUTO.
INSERT INTO Produto VALUES (10, 'Sabonete em Barra', 2);
INSERT INTO Produto VALUES (11, 'Shampoo Anticaspa', 1);
INSERT INTO Produto VALUES (12, 'Desodorante Aerosol Neutro', 2);
INSERT INTO Produto VALUES (13, 'Sabonete Liquido', 2);
INSERT INTO Produto VALUES (14, 'Protetor Solar 30', 3);
INSERT INTO Produto VALUES (15, 'Shampoo 2 em 1', 2);
INSERT INTO Produto VALUES (16, 'Desodorante Aerosol Morango', 2);
INSERT INTO Produto VALUES (17, 'Shampoo Anticaspa', 2);
INSERT INTO Produto VALUES (18, 'Protetor Solar 60', 3);
INSERT INTO Produto VALUES (19, 'Desodorante Rollon', 1);

-- Inserindo registros na tabela LOTE.
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, codproduto) VALUES (100, '2028-08-05', 9.90, 500, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, codproduto) VALUES (101, '2027-05-01', 8.47, 500, 10);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (102, '2028-06-02', 11.50, 750, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (103, '2026-02-01', 12.37, 383, DEFAULT, 18);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (104, '2027-01-01', 10.00, 400, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (105, '2026-04-07', 11.50, DEFAULT, DEFAULT, 15);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (106, '2023-06-08', 10.30, 320, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (107, '2024-10-20', 13.90, 456, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (108, '2026-07-20', 7.53, 750, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (109, '2025-05-13', 8.00, 720, DEFAULT, 11);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (110, '2027-06-05', 9.50, 860, DEFAULT, 13);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (111, '2028-03-02', 14.50, 990, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (112, '2028-04-05', 11.40, 430, DEFAULT, 14);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (113, '2025-06-04', 11.30, 200, DEFAULT, 12);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (114, '2027-10-06', 12.76, 380, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (115, '2028-11-06', 8.30, 420, DEFAULT, 17);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (116, '2027-10-20', 8.99, 361, DEFAULT, 19);
INSERT INTO Lote (numlote, datavalidade, precounitario, quantidade, valorlote, codproduto) VALUES (117, '2024-11-15', 10.09, 713, DEFAULT, 11);

UPDATE Lote
SET valorlote = (precounitario*quantidade)
WHERE numlote >= 100

Select * FROM Lote

--1. Quais os lotes com data de validade para o ano de 2024.
SELECT * FROM Lote 
WHERE YEAR(datavalidade) = YEAR('01-01-2024')

--2. Quantos lotes possuem data de validade para o ano de 2025.
SELECT COUNT(*) FROM Lote 
WHERE YEAR(datavalidade) = YEAR('01-01-2025')

--3. Quantos lotes existem para cada produto.
SELECT 
	p.nomeproduto , COUNT(*) AS 'Quantos Lotes existem paraca cada produto'
FROM 
	Lote l
JOIN
	Produto p ON l.codproduto = p.codproduto
GROUP BY p.nomeproduto

--4. Qual o valor total de lotes de um determinado produto.
SELECT
	p.nomeproduto AS Produto, SUM(valorlote) AS 'Total de lotes'
FROM 
	Lote l
JOIN
	Produto p ON l.codproduto = p.codproduto
WHERE
	l.codproduto = p.codproduto
GROUP 
	BY p.nomeproduto

--5. Criar lista ordenada de lotes por data de validade.
SELECT * FROM Lote ORDER BY datavalidade

--6. Selecionar lotes com validade entre fevereiro de 2024 e junho de 2026
SELECT * FROM Lote
WHERE
	datavalidade >= (CONVERT(DATE, '01-02-2024'))
AND
	datavalidade <= (CONVERT(DATE, '01-06-2026'))

--7. Listar os lotes com valor de lote acima da média entre todos os valores 
--de lote do banco. ++
SELECT * FROM Lote
WHERE valorlote > (SELECT AVG(valorlote) FROM Lote)

	--a. Um pequeno mercado comprou um lote fechado do Sabonete de 
	--Glicerina do fabricante Ancora. A validade desses sabonetes está 
	--para 28/12/29. Cada unidade desse sabonete custou R $3,78 
	--para nossa empresa. Foi encomendado um lote com 1.223 
	--unidades. Registre essas informações no banco de dados
	INSERT INTO 
		Fabricante(codfabricante, nomefabricante) 
	VALUES
		(5,'Ancora')

	INSERT INTO 
		Produto(codproduto, nomeproduto, codfabricante)
	VALUES(20, 'Sabonete de Glicerina', 5)

	INSERT INTO 
		Lote(numlote, datavalidade, precounitario, quantidade, valorlote, codproduto)
	VALUES
		(118, '28-12-2029', 3.78, 1223, 3.78*1223, 20);

--8. Alterar o preço do Sabonete de Glicerina com uma redução de 15% no 
--preço cadastrado.
UPDATE Lote
SET precounitario = precounitario*0.85
WHERE codproduto = 20

--9. Excluir o Shampoo Anticaspa da Rexona.
--Shampoo Anticaspa da Rexona codproduto = 17

--Para evitar erros primeiro excluí as linhas do Lote
DELETE FROM Lote
WHERE codproduto = 17

DELETE FROM Produto
WHERE codproduto = 17

--10.Altere a tabela lote de forma que o armazenamento do preço unitário do 
--produto seja feito usando apenas duas casas decimais.
ALTER TABLE Lote
ALTER COLUMN precounitario DECIMAL(10,2);

--11.Altere a tabela lote inserindo uma coluna chamada STATUSLOTE. Essa 
--coluna pode armazenar valores como “Recall”, “Liberado”. Como 
--padrão, esse campo recebe valor de “Analise”. A coluna deve ser 
--varchar e receber no máximo 9 caracteres.
ALTER TABLE Lote
ADD STATUSLOTE VARCHAR(9) DEFAULT 'Analise';

ALTER TABLE Lote
ADD CONSTRAINT chk_STATUSLOTE CHECK(STATUSLOTE IN ('Analise', 'Recall', 'Liberado'));

UPDATE Lote
SET STATUSLOTE = 'Analise'
WHERE numlote > 0

--12.Alterar o status dos lotes de acordo com a tabela abaixo ++
UPDATE Lote
SET STATUSLOTE = 'Recall'
WHERE numlote = 107 OR numlote = 108 OR numlote = 116

UPDATE Lote
SET STATUSLOTE = 'Liberado'
WHERE numlote = 113 OR numlote = 117 OR numlote = 112 OR numlote = 109 OR numlote = 114

--13.Criar uma lista com a quantidade de lotes que estão classificados com 
--cada um dos status existentes.
SELECT STATUSLOTE ,COUNT(*) FROM Lote
GROUP BY STATUSLOTE

--14.Apresentar uma lista com as quantidades de produtos fornecidas por 
--cada fabricante
SELECT f.nomefabricante , SUM(quantidade) AS Quantidade
	FROM
		Lote l
JOIN
	Produto p ON l.codproduto = p.codproduto
JOIN
	Fabricante f ON p.codfabricante = f.codfabricante

GROUP BY f.nomefabricante