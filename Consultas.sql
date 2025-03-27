USE Locadora
GO
-- Alterar o status dos filmes que n�o foram devolvidos de D(Dispon�vel) para E(Emprestado)

SELECT * FROM Filme AS Film
RIGHT JOIN Loca��o AS Loc 
	ON Film.CodFilme = Loc.CodFilme
	WHERE Loc.DataDevolucao IS NULL;

UPDATE Filme 
	SET Status = 'E'
		WHERE CodFilme IN (	SELECT CodFilme
							FROM Loca��o
								WHERE DataDevolucao IS NULL);

-- Exibir o nome dos filmes, a descri��o de seu g�nero, mas somente para os filmes que est�o dispon�veis (status 'D').

SELECT Film.Nome, Gen.Descricao AS 'G�nero'
FROM Filme AS Film
LEFT JOIN G�nero AS Gen
	ON Gen.CodGenero = Film.CodGenero
		WHERE Film.Status = 'D'
ORDER BY Film.Nome


-- Exibir o nome dos filmes, seu c�digo, e sua data de loca��o, mas somente para os filmes que ainda n�o foram devolvidos.

SELECT Film.CodFilme, Film.Nome, Loc.DataLocacao
FROM Filme AS Film
RIGHT JOIN Loca��o AS Loc
	ON Loc.CodFilme = Film.CodFilme
		WHERE DataDevolucao IS NULL
ORDER BY Film.Nome

-- Exibir o c�digo, nome e pre�o dos filmes do g�nero �Aventura�.

SELECT CodFilme, Nome, Prec.Valor
FROM Filme as Film
LEFT JOIN Pre�o AS Prec ON Prec.Cor = Film.Cor
JOIN G�nero AS Gen
	ON Gen.CodGenero = Film.CodGenero
		WHERE Gen.Descricao = 'Aventura';

-- Exibir o c�digo e nome dos filmes de com�dia alugadas por clientes do Rio de Janeiro. Exibir tamb�m o nome e c�digo desses clientes.

SELECT Cl.CodCliente, Cl.Nome, Film.CodFilme, Film.Nome
FROM Cliente AS Cl
	LEFT JOIN Loca��o AS Loc
		ON Loc.CodCliente = Cl.CodCliente
	JOIN Filme as Film
		ON Loc.CodFilme = Film.CodFilme
			WHERE Film.CodGenero = (SELECT Gen.CodGenero
									FROM G�nero AS Gen
									WHERE Gen.Descricao = 'Com�dia') AND Cl.Cidade = 'Rio de Janeiro'

-- Exibir o c�digo e nome dos filmes que possuem a mesma cor do filme 231.

SELECT CodFilme, Nome
FROM Filme
WHERE Cor = ALL (SELECT Cor 
				 FROM Filme
					WHERE CodFilme = 231)

-- Exibir o c�digo e nome dos clientes que moram no mesmo estado dos clientes que alugaram filme no m�s de outubro.

SELECT Cl.CodCliente, Cl.Nome 
FROM Cliente AS Cl
WHERE Cl.Estado in (SELECT Cl.Estado
					FROM Loca��o AS Loc
						JOIN Cliente as Cl
							ON Cl.CodCliente = Loc.CodCliente
								WHERE MONTH(DataLocacao) = 10)

-- Exibir o c�digo e nome dos clientes que realizaram mais loca��es do que o cliente de c�digo 100.

SELECT Cl.CodCliente, Cl.Nome, COUNT(*) AS 'Qtde. Loca��es'
FROM Cliente AS Cl
JOIN Loca��o AS Loc
	ON Cl.CodCliente = Loc.CodCliente
	GROUP BY Cl.CodCliente, Cl.Nome
	HAVING COUNT(*) > (SELECT COUNT(CodCliente)
					FROM Loca��o
						WHERE CodCliente = 100)

-- Exibir o c�digo e nome dos filmes que possuem mesma cor que os filmes de Suspense.

SELECT CodFilme, Nome, Cor
From Filme
	WHERE EXISTS ( SELECT Cor
					  FROM Filme AS Film
						LEFT JOIN G�nero AS Gen
							ON Film.CodGenero = Gen.CodGenero
							WHERE Descricao = 'Suspense')