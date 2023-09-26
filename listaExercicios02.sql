1. Listagem de Autores:

sql
DELIMITER //

CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;


DELIMITER ;
