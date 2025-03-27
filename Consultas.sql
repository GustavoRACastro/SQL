USE Locadora
GO
-- Alterar o status dos filmes que não foram devolvidos de D(Disponível) para E(Emprestado)

SELECT * FROM Filme AS Film
RIGHT JOIN Locação AS Loc 
	ON Film.CodFilme = Loc.CodFilme
	WHERE Loc.DataDevolucao IS NULL;

UPDATE Filme 
	SET Status = 'E'
		WHERE CodFilme IN (	SELECT CodFilme
							FROM Locação
								WHERE DataDevolucao IS NULL);

-- Exibir o nome dos filmes, a descrição de seu gênero, mas somente para os filmes que estão disponíveis (status 'D').

SELECT Film.Nome, Gen.Descricao AS 'Gênero'
FROM Filme AS Film
LEFT JOIN Gênero AS Gen
	ON Gen.CodGenero = Film.CodGenero
		WHERE Film.Status = 'D'
ORDER BY Film.Nome


-- Exibir o nome dos filmes, seu código, e sua data de locação, mas somente para os filmes que ainda não foram devolvidos.

SELECT Film.CodFilme, Film.Nome, Loc.DataLocacao
FROM Filme AS Film
RIGHT JOIN Locação AS Loc
	ON Loc.CodFilme = Film.CodFilme
		WHERE DataDevolucao IS NULL
ORDER BY Film.Nome

-- Exibir o código, nome e preço dos filmes do gênero ‘Aventura’.

SELECT CodFilme, Nome, Prec.Valor
FROM Filme as Film
LEFT JOIN Preço AS Prec ON Prec.Cor = Film.Cor
JOIN Gênero AS Gen
	ON Gen.CodGenero = Film.CodGenero
		WHERE Gen.Descricao = 'Aventura';

-- Exibir o código e nome dos filmes de comédia alugadas por clientes do Rio de Janeiro. Exibir também o nome e código desses clientes.

SELECT Cl.CodCliente, Cl.Nome, Film.CodFilme, Film.Nome
FROM Cliente AS Cl
	LEFT JOIN Locação AS Loc
		ON Loc.CodCliente = Cl.CodCliente
	JOIN Filme as Film
		ON Loc.CodFilme = Film.CodFilme
			WHERE Film.CodGenero = (SELECT Gen.CodGenero
									FROM Gênero AS Gen
									WHERE Gen.Descricao = 'Comédia') AND Cl.Cidade = 'Rio de Janeiro'

-- Exibir o código e nome dos filmes que possuem a mesma cor do filme 231.

SELECT CodFilme, Nome
FROM Filme
WHERE Cor = ALL (SELECT Cor 
				 FROM Filme
					WHERE CodFilme = 231)

-- Exibir o código e nome dos clientes que moram no mesmo estado dos clientes que alugaram filme no mês de outubro.

SELECT Cl.CodCliente, Cl.Nome 
FROM Cliente AS Cl
WHERE Cl.Estado in (SELECT Cl.Estado
					FROM Locação AS Loc
						JOIN Cliente as Cl
							ON Cl.CodCliente = Loc.CodCliente
								WHERE MONTH(DataLocacao) = 10)

-- Exibir o código e nome dos clientes que realizaram mais locações do que o cliente de código 100.

SELECT Cl.CodCliente, Cl.Nome, COUNT(*) AS 'Qtde. Locações'
FROM Cliente AS Cl
JOIN Locação AS Loc
	ON Cl.CodCliente = Loc.CodCliente
	GROUP BY Cl.CodCliente, Cl.Nome
	HAVING COUNT(*) > (SELECT COUNT(CodCliente)
					FROM Locação
						WHERE CodCliente = 100)

-- Exibir o código e nome dos filmes que possuem mesma cor que os filmes de Suspense.

SELECT CodFilme, Nome, Cor
From Filme
	WHERE EXISTS ( SELECT Cor
					  FROM Filme AS Film
						LEFT JOIN Gênero AS Gen
							ON Film.CodGenero = Gen.CodGenero
							WHERE Descricao = 'Suspense')