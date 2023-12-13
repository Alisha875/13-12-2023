CREATE DATABASE Assessment05Db;

USE Assessment05Db;

IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bank')
    DROP SCHEMA bank;

CREATE SCHEMA bank;

CREATE TABLE bank.Customer (
    CId INT PRIMARY KEY,
    CName NVARCHAR(100) NOT NULL,
    CEmail NVARCHAR(100) UNIQUE NOT NULL,
    CPwd NVARCHAR(100) NOT NULL,
    Contact NVARCHAR(100) NOT NULL
);

CREATE TABLE bank.MailInfo (
    MailTo NVARCHAR(100) NOT NULL,
	MailDate DATE NOT NULL,
    MailMessage NVARCHAR(1000) NOT NULL
);

CREATE TRIGGER bank.trgMailToCust
ON bank.Customer
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO bank.MailInfo (MailTo, MailDate, MailMessage)
    SELECT CEmail, GETDATE(), 'Your net banking password is ' + CPwd + '. It is valid up to 2 days only.'
    FROM inserted;
END;

INSERT INTO bank.Customer (CId, CName, CEmail, CPwd, Contact)
VALUES
    (1, 'Customer1', 'customer1@email.com', 'password1', 'contact1'),
    (2, 'Customer2', 'customer2@email.com', 'password2', 'contact2'),
    (3, 'Customer3', 'customer3@email.com', 'password3', 'contact3');


SELECT * FROM bank.Customer;
SELECT * FROM bank.MailInfo;

