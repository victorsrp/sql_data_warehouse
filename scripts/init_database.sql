/*
=============================================================
Criação do Banco de Dados e Schemas
=============================================================
Propósito do Script:
    Este script cria um novo banco de dados chamado 'DataWarehouse' após verificar se ele já existe. 
    Se o banco de dados existir, ele será removido e recriado. Além disso, o script configura três schemas 
    dentro do banco de dados: 'bronze', 'silver' e 'gold'.
	
ATENÇÃO:
    A execução deste script removerá completamente o banco de dados 'DataWarehouse' caso ele já exista. 
    Todos os dados contidos no banco de dados serão permanentemente excluídos. Prossiga com cautela 
    e certifique-se de ter backups adequados antes de executar este script.
*/

USE master;
GO

-- Deletendo e recriando 'DataWarehouse' database caso ja exista
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Criando o 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Criando Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
