IF DB_ID('OTEL') IS NOT NULL
	BEGIN
		ALTER DATABASE OTEL SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE master
		DROP DATABASE OTEL
	END
GO

/************************************************
				DATABASE OLUÞTURMA
************************************************/
CREATE DATABASE OTEL
	ON PRIMARY(
		NAME = 'otel_db',
		FILENAME = 'w:\database\otel_db.ldf',
		SIZE = 20MB,
		MAXSIZE = 100MB,
		FILEGROWTH = 10MB
	)
	LOG ON(
		NAME = 'otel_log',
		FILENAME = 'w:\database\otel_log.ldf',
		SIZE = 10MB,
		MAXSIZE = 60MB,
		FILEGROWTH = 5MB
	)
GO
USE OTEL
/************************************************
					TABLOLAR
************************************************/

/******************   OTEL OLANAKLARI   ******************/
CREATE TABLE OtelOlanaklari(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(40) NOT NULL
)
GO

-- ÝL
CREATE TABLE Il(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(20) NOT NULL
)
GO

-- ÇALIÞAN
CREATE TABLE Calisan(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KimlikNo CHAR(11) UNIQUE NOT NULL,
	AdSoyad AS Ad + ' ' + Soyad,
		Ad NVARCHAR(30) NOT NULL,
		Soyad NVARCHAR (30) NOT NULL,
	DogumTarihi DATE NOT NULL,
	Yas AS DATEDIFF(yy,DogumTarihi,GETDATE()),
	TelefonNumarasi CHAR(10) NOT NULL CONSTRAINT CalisanTelefonNumarasiType CHECK(TelefonNumarasi LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Email NVARCHAR(255) NOT NULL CONSTRAINT UQ_CalisanEmail UNIQUE
							     CONSTRAINT CHK_CalisanMailType CHECK (Email LIKE '%@%.%'),
	Cinsiyet CHAR(1) NOT NULL CONSTRAINT CHK_CalisanCinsiyetler CHECK(cinsiyet = 'E' OR cinsiyet = 'K' OR cinsiyet = 'D'),
)
GO

-- MÜÞTERÝ
CREATE TABLE Musteri(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KimlikNo CHAR(11) NOT NULL,
	AdSoyad AS Ad + ' ' + Soyad,
		Ad NVARCHAR(30) NOT NULL,
		Soyad NVARCHAR (30) NOT NULL,
	DogumTarihi DATE NOT NULL,
	Yas AS DATEDIFF(yy,DogumTarihi,GETDATE()),
	TelefonNumarasi CHAR(10) NOT NULL CONSTRAINT CHK_MusteriTelefonNumarasiType CHECK(TelefonNumarasi LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Email NVARCHAR(255) -- NULL CONSTRAINT UQ_MusteriEmail UNIQUE
					   CONSTRAINT CHK_MusteriMailType CHECK(Email LIKE '%@%.%'),
	Cinsiyet CHAR(1) NOT NULL CONSTRAINT CHK_MusteriCinsiyetler CHECK(cinsiyet = 'E' OR cinsiyet = 'K' OR cinsiyet = 'D')
)
GO

-- EK HÝZMET
CREATE TABLE EkHizmet(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad NVARCHAR(40) NOT NULL
)
GO

-- ODA TÝPÝ
CREATE TABLE OdaTipi(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad NVARCHAR(40) NOT NULL
)
GO

/************************************************
				BAÐLANTILI TABLOLAR
************************************************/

CREATE TABLE Rezervasyon(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	BaslangicTarihi DATETIME DEFAULT GETDATE(),
	BitisTarihi DATETIME,
	CikisTarihi DATETIME DEFAULT NULL,
	SilinmeTarihi DATETIME DEFAULT NULL, --Rezerve Eder
	MusteriId INT FOREIGN KEY REFERENCES Musteri(Id) --Rezerve Eder
)
GO

-- ÝLÇE
CREATE TABLE Ilce(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad NVARCHAR(20) NOT NULL,
	-- 1-N
	IlId INT FOREIGN KEY REFERENCES Il(Id) --Sahip
)
GO

-- OTEL
CREATE TABLE Otel(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad NVARCHAR(30),
	Telefon VARCHAR(10) NOT NULL CONSTRAINT CHK_OtelTelefonType CHECK(Telefon LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Adres NVARCHAR(MAX),
	Email NVARCHAR(50) NOT NULL CONSTRAINT CHK_OtelEmailType CHECK(Email LIKE '%@%.%')
							   CONSTRAINT UQ_OtelEmail UNIQUE,
	OdaSayisi AS 241,
--	OdaSayisi AS (SELECT COUNT(*) FROM Oda WHERE OtelId = Id),
	OtelPuan DECIMAL CONSTRAINT CHK_OtelPuanType CHECK(OtelPuan >= 0 AND OtelPuan <= 5),
	OtelYildiz CHAR(1) CONSTRAINT CHK_OtelYildiz CHECK(OtelYildiz LIKE '[0-5]'),
	IlId INT FOREIGN KEY REFERENCES Il(Id), --Sahip
	IlceId INT FOREIGN KEY REFERENCES Ilce(Id) --Sahip
)
GO

-- ODA
CREATE TABLE Oda(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Kapasite CHAR(1),
	OtelId INT FOREIGN KEY REFERENCES Otel(Id), --Sahip
	OdaTipiId INT FOREIGN KEY REFERENCES OdaTipi(Id) --Sahip
)
GO

-- FÝYAT
CREATE TABLE Fiyat(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Deger SMALLMONEY,
	BaslangicTarihi DATETIME,
	BitisTarihi DATETIME,
	OtelOlanaklariId INT NULL CONSTRAINT FK_Fiyat_OtelOlanaklari_OtelOlanaklariId FOREIGN KEY REFERENCES OtelOlanaklari(Id), --Sahip
	OdaTipiId INT NULL CONSTRAINT FK_Fiyat_OdaTipi_OdaTipiId FOREIGN KEY REFERENCES OdaTipi(Id), --Sahip
	EkHizmetId INT NULL CONSTRAINT FK_Fiyat_EkHizmet_EkHizmetId FOREIGN KEY REFERENCES EkHizmet(Id) --Sahip
)
GO

/************************************************
				ÝLÝÞKÝ TABLOLARI
************************************************/

-- Otel & Otel Olanaklarý ÝLÝÞKÝ TABLOSU // SAHÝP
CREATE TABLE Otel_Olanaklar(
	OtelId INT FOREIGN KEY REFERENCES Otel(Id),
	OlanakId INT FOREIGN KEY REFERENCES OtelOlanaklari(Id),
	CONSTRAINT PK_Otek_Olanaklar PRIMARY KEY(OtelId, OlanakId)
)
GO

-- Otel & Calisan ÝLÝÞKÝ TABLOSU // ÇALIÞIR
CREATE TABLE Otel_Calisan(
	OtelId INT FOREIGN KEY REFERENCES Otel(Id),
	CalisanId INT FOREIGN KEY REFERENCES Calisan(Id),
	Maas SMALLMONEY,
	BaslangicTarihi DATETIME DEFAULT GETDATE(),
	CikisTarihi DATETIME DEFAULT NULL,
	SilinmeTarihi DATETIME DEFAULT NULL,
	CONSTRAINT PK_Otel_Calisan PRIMARY KEY(OtelId, CalisanId)
)
GO

-- Ek Hizmet & Oda ÝLÝÞKÝ TABLOSU // SAHÝP
CREATE TABLE EkHizmet_Oda(
	EkHizmetId INT FOREIGN KEY REFERENCES EkHizmet(Id),
	OdaId INT FOREIGN KEY REFERENCES Oda(Id),
	CONSTRAINT PK_EkHizmet_Oda PRIMARY KEY(EkHizmetId, OdaId)
)
GO

-- Ek Hizmet & Rezervasyon ÝLÝÞKÝ TABLOSU // FÝYATLANDIRIR
CREATE TABLE EkHizmet_Rezervasyon(
	EkHizmetId INT FOREIGN KEY REFERENCES EkHizmet(Id),
	RezervasyonId INT FOREIGN KEY REFERENCES Rezervasyon(Id),
	CONSTRAINT PK_EkHizmet_Rezervasyon PRIMARY KEY(EkHizmetId, RezervasyonId)
)
GO

-- Otel Olanaklarý & Rezervasyon ÝLÝÞKÝ TABLOSU // FÝYATLANDIRIR
CREATE TABLE Olanak_Rezervasyon(
	OlanakId INT FOREIGN KEY REFERENCES OtelOlanaklari(Id),
	RezervasyonId INT FOREIGN KEY REFERENCES Rezervasyon(Id),
	CONSTRAINT PK_Olanak_Rezervasyon PRIMARY KEY(OlanakId, RezervasyonId)
)
GO

-- Oda & Rezervasyon ÝLÝÞKÝ TABLOSU // SAHÝP
CREATE TABLE Oda_Rezervasyon(
	OdaId INT FOREIGN KEY REFERENCES Oda(Id),
	RezervasyonId INT FOREIGN KEY REFERENCES Rezervasyon(Id),
	CONSTRAINT PK_Oda_Rezervasyon PRIMARY KEY(OdaId, RezervasyonId)
)
GO

-- Müþteri & Rezervasyon ÝLÝÞKÝ TABLOSU // KALIR
CREATE TABLE Musteri_Rezervasyon(
	MusteriId INT FOREIGN KEY REFERENCES Musteri(Id),
	RezervasyonId INT FOREIGN KEY REFERENCES Rezervasyon(Id),
	CONSTRAINT PK_Musteri_Rezervasyon PRIMARY KEY(MusteriId, RezervasyonId)
)
GO