1. Listagem de Autores:

sql
DELIMITER //

CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;


DELIMITER ;


2. Livros por Categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;


DELIMITER ;

3. Contagem de Livros por Categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT totalLivros INT)
BEGIN
    SELECT COUNT(*) INTO totalLivros
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;


DELIMITER ;

4. Verificação de Livros por Categoria:

sql
DELIMITER //

CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros BOOLEAN)
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    IF total > 0 THEN
        SET possuiLivros = TRUE;
    ELSE
        SET possuiLivros = FALSE;
    END IF;


DELIMITER ;


5. Listagem de Livros por Ano:

sql
DELIMITER //

CREATE PROCEDURE sp_LivrosAteAno(IN anoLimite INT)
BEGIN
    SELECT Titulo
    FROM Livro
    WHERE Ano_Publicacao <= anoLimite;


DELIMITER ;

6. Extração de Títulos por Categoria (Usando Cursor):

sql
DELIMITER //

CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE livroTitulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Livro.Titulo
        FROM Livro
        INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
        WHERE Categoria.Nome = categoriaNome;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO livroTitulo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT livroTitulo;
    END LOOP;
    CLOSE cur;


DELIMITER ;

7. Adição de Livro com Tratamento de Erros:

sql
DELIMITER //

CREATE PROCEDURE sp_AdicionarLivro(IN titulo VARCHAR(255), IN editoraID INT, IN anoPublicacao INT, IN numPaginas INT, IN categoriaID INT, OUT mensagem VARCHAR(255))
BEGIN
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET mensagem = 'Erro: Título de livro já existe.';
    END;

    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
    VALUES (titulo, editoraID, anoPublicacao, numPaginas, categoriaID);

    SET mensagem = 'Livro adicionado com sucesso.';


DELIMITER ;

8. Autor Mais Antigo:

sql
DELIMITER //

CREATE PROCEDURE sp_AutorMaisAntigo(OUT autorMaisAntigo VARCHAR(255))
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome) INTO autorMaisAntigo
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);


DELIMITER ;

sql
-- Descrição da stored procedure
-- Autor: Seu Nome
-- Data: Data de Criação
-- Descrição: Esta stored procedure faz o seguinte...

DELIMITER //

CREATE PROCEDURE sp_SuaProcedure(IN parametro1 TIPO, OUT parametro2 TIPO)
BEGIN
    -- Comentários adicionados para explicar o funcionamento do código SQL
    -- ...


DELIMITER 


10. Livros e Seus Autores:

sql
DELIMITER //

CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.Titulo, CONCAT(Autor.Nome, ' ', Autor.Sobrenome) AS 'Autor'
    FROM Livro
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID;


DELIMITER ;
