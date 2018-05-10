/************************************************
					OTEL
************************************************/

/************************************************
				DATABASE KALDIRMA
************************************************/
IF DB_ID('OTEL') IS NOT NULL
	BEGIN
		ALTER DATABASE OTEL SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		USE master
		DROP DATABASE OTEL
	END
GO

/************************************************
				DATABASE OLUSTURMA
************************************************/
CREATE DATABASE OTEL
	ON PRIMARY(
		NAME = 'otel_db',
		FILENAME = 'W:\database\otel_db.ldf',
		SIZE = 20MB,
		MAXSIZE = 100MB,
		FILEGROWTH = 10MB
	)
	LOG ON(
		NAME = 'otel_log',
		FILENAME = 'W:\database\otel_log.ldf',
		SIZE = 10MB,
		MAXSIZE = 60MB,
		FILEGROWTH = 5MB
	)
GO
USE OTEL

/************************************************
					TABLOLAR
************************************************/

/* IL */
CREATE TABLE Il(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(20) NOT NULL
)
GO

/* ILCE */
CREATE TABLE Ilce(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(20) NOT NULL,
	IlId INT NOT NULL CONSTRAINT FK_Ilce_Il_IlId FOREIGN KEY (IlId) REFERENCES Il (Id)
)
GO

/* OTEL */
CREATE TABLE Otel(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(100) NOT NULL,
	Telefon VARCHAR(13) NOT NULL CONSTRAINT CHK_Otel_Telefon CHECK(Telefon LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Adres VARCHAR(MAX),
	Email VARCHAR(256) NOT NULL CONSTRAINT CHK_Otel_Email CHECK(Email LIKE '%@%.%')
								CONSTRAINT UQ_Otel_Email UNIQUE,
	OtelYildizi INT CONSTRAINT CHK_Otel_OtelYildizi CHECK(OtelYildizi LIKE '[0-5]'),
	OtelPuani DECIMAL CONSTRAINT CHK_Otel_OtelPuani CHECK(OtelPuani >= 0 AND OtelPuani <= 5),
	OdaSayisi AS 241,
	IlId INT NOT NULL CONSTRAINT FK_Otel_Il_IlId FOREIGN KEY (IlId) REFERENCES Il (Id),
	IlceId INT NOT NULL CONSTRAINT FK_Otel_Ilce_IlceId FOREIGN KEY (IlceId) REFERENCES Ilce (Id),
)
GO

/* OTEL OLANAKLARI */
CREATE TABLE OtelOlanaklari(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR(40) NOT NULL,
)
GO

/* CALISAN */
CREATE TABLE Calisan(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	KimlikNo CHAR(11) UNIQUE NOT NULL,
	-- Cinsiyet TINYINT NOT NULL, TODO: hocaya sor cunku hoca integer 1,2,3 gibi tutarsiniz demisti
	Cinsiyet CHAR(1) NOT NULL CONSTRAINT CHK_Calisan_Cinsiyet CHECK(Cinsiyet = 'E' OR Cinsiyet = 'K' OR Cinsiyet = 'D'),
	TelefonNumarasi VARCHAR(13) CONSTRAINT CHK_Calisan_TelefonNumarasi CHECK(TelefonNumarasi LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	Ad NVARCHAR(30) NOT NULL,
	Soyad NVARCHAR(30) NOT NULL,
	AdSoyad AS Ad + ' ' + Soyad,
	DogumTarihi DATE NOT NULL,
	Email VARCHAR(256) NULL CONSTRAINT UQ_Calisan_Email UNIQUE
							CONSTRAINT CHK_Calisan_Email CHECK (Email LIKE '%@%.%'),
)
GO

/* ODA TIPI */
CREATE TABLE OdaTipi(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR (25) NOT NULL
)
GO

/* ODA */
CREATE TABLE Oda(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Kapasite TINYINT NOT NULL,
	OtelId INT NOT NULL CONSTRAINT FK_Oda_Otel_OtelId FOREIGN KEY (OtelId) REFERENCES Otel(Id),
	OdaTipiId INT NOT NULL CONSTRAINT FK_Oda_Odatipi_OdaTipiId FOREIGN KEY (OdaTipiId) REFERENCES OdaTipi(Id)
)
GO

/* EK HIZMET */
CREATE TABLE EkHizmet(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad VARCHAR (25) NOT NULL
)
GO

/* FIYAT */
CREATE TABLE Fiyat(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Deger SMALLMONEY NOT NULL,
	BaslangicTarihi DATETIME NOT NULL DEFAULT GETDATE(),
	BitisTarihi DATETIME NOT NULL,
	OtelOlanaklariId INT CONSTRAINT FK_Fiyat_OtelOlanaklari_OtelOlanaklariId FOREIGN KEY (OtelOlanaklariId) REFERENCES OtelOlanaklari(Id),
	OdaTipiId INT CONSTRAINT FK_Fiyat_Odatipi_OdaTipiId FOREIGN KEY (OdaTipiId) REFERENCES OdaTipi(Id),
	EkHizmetId INT CONSTRAINT FK_Fiyat_EkHizmet_EkHizmetId FOREIGN KEY (EkHizmetId) REFERENCES EkHizmet(Id)
)
GO

/* MUSTERI */
CREATE TABLE Musteri(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Ad NVARCHAR(30) NOT NULL,
	Soyad NVARCHAR(30) NOT NULL,
	KimlikNo CHAR(11), -- TODO: NOT NULL eklenirse yabanci misafirlerin kimlik numarasi olmayacak bunu dusunelim
	DogumTarihi DATE NOT NULL,
	Email VARCHAR(256) -- TODO: unique eklenmeli ama nullable olmali hocaya sor CONSTRAINT UQ_Musteri_Email UNIQUE
					   CONSTRAINT CHK_Musteri_Email CHECK (Email LIKE '%@%.%'),
	TelefonNumarasi VARCHAR(13) CONSTRAINT CHK_Musteri_TelefonNumarasi CHECK(TelefonNumarasi LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	-- Cinsiyet TINYINT NOT NULL, TODO: hocaya sor cunku hoca integer 1,2,3 gibi tutarsiniz demisti
	Cinsiyet CHAR(1) NOT NULL CONSTRAINT CHK_Musteri_Cinsiyet CHECK(Cinsiyet = 'E' OR Cinsiyet = 'K' OR Cinsiyet = 'D')
)
GO

/* REZERVASYON */
CREATE TABLE Rezervasyon(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	BaslangicTarihi DATETIME NOT NULL DEFAULT GETDATE(),
	CikisTarihi DATETIME DEFAULT NULL,
	BitisTarihi DATETIME NOT NULL,
	SilinmeTarihi DATETIME DEFAULT NULL, -- TODO: gerek yoksa kaldirmayi dusunelim
	MusteriId INT NOT NULL CONSTRAINT FK_Rezervasyon_Musteri_MusteriId FOREIGN KEY (MusteriId) REFERENCES Musteri(Id)
)
GO

/************************************************
			ILISKIDEN DOGAN TABLOLAR
************************************************/

/* OTEL - OTEL OLANAKLARI */
CREATE TABLE Otel_OtelOlanaklari(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	OtelId INT NOT NULL CONSTRAINT FK_Otel_OtelOlanaklari_Otel_OtelId FOREIGN KEY (OtelId) REFERENCES Otel(Id),
	OtelOlanaklariId INT NOT NULL CONSTRAINT FK_Otel_OtelOlanaklari_OtelOlanaklari_OtelOlanaklariId FOREIGN KEY (OtelOlanaklariId) REFERENCES OtelOlanaklari(Id)
)
GO

/* OTEL - CALISAN */
CREATE TABLE Otel_Calisan(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	OtelId INT NOT NULL CONSTRAINT FK_Otel_Calisan_Otel_OtelId FOREIGN KEY (OtelId) REFERENCES Otel(Id),
	CalisanId INT NOT NULL CONSTRAINT FK_Otel_Calisan_Calisan_CalisanId FOREIGN KEY (CalisanId) REFERENCES Calisan(Id),
	Maas SMALLMONEY NOT NULL,
	SilinmeTarihi DATETIME DEFAULT NULL, -- TODO: cikis tarihi tutuyoz buna ihtiyac yok gibi, hocaya danisalim
	BaslangicTarihi DATETIME NOT NULL DEFAULT GETDATE(),
	CikisTarihi DATETIME DEFAULT NULL
)
GO

/* ODA - EK HIZMET */
CREATE TABLE Oda_EkHizmet(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	OdaId INT NOT NULL CONSTRAINT FK_Oda_EkHizmet_Oda_OdaId FOREIGN KEY (OdaId) REFERENCES Oda(Id),
	EkHizmetId INT NOT NULL CONSTRAINT FK_Oda_EkHizmet_EkHizmet_EkHizmetId FOREIGN KEY (EkHizmetId) REFERENCES EkHizmet(Id)
)
GO

/* REZERVASYON - MUSTERI */
CREATE TABLE Rezervasyon_Musteri(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	RezervasyonId INT NOT NULL CONSTRAINT FK_Rezervasyon_Musteri_Rezervasyon_RezervasyonId FOREIGN KEY (RezervasyonId) REFERENCES Rezervasyon(Id),
	MusteriId INT NOT NULL CONSTRAINT FK_Rezervasyon_Musteri_Musteri_MusteriId FOREIGN KEY (MusteriId) REFERENCES Musteri(Id),
	-- SilinmeTarihi DATETIME DEFAULT NULL, TODO: bunda yanlislik yaptigimizi farkettik hocaya danisip kaldirmayi dusunelim
)
GO

/* REZERVASYON - ODA */
CREATE TABLE Rezervasyon_Oda(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	RezervasyonId INT NOT NULL CONSTRAINT FK_Rezervasyon_Oda_Rezervasyon_RezervasyonId FOREIGN KEY (RezervasyonId) REFERENCES Rezervasyon(Id),
	OdaId INT NOT NULL CONSTRAINT FK_Rezervasyon_Oda_Oda_OdaId FOREIGN KEY (OdaId) REFERENCES Oda(Id),
	ToplamTutar INT NOT NULL,
	OlusturmaTarihi DATETIME NOT NULL DEFAULT GETDATE()
)
GO

/* REZERVASYON - EK HIZMET */
CREATE TABLE Rezervasyon_EkHizmet(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	RezervasyonId INT NOT NULL CONSTRAINT FK_Rezervasyon_EkHizmet_Rezervasyon_RezervasyonId FOREIGN KEY (RezervasyonId) REFERENCES Rezervasyon(Id),
	EkHizmetId INT NOT NULL CONSTRAINT FK_Rezervasyon_EkHizmet_EkHizmet_EkHizmetId FOREIGN KEY (EkHizmetId) REFERENCES EkHizmet(Id),
	ToplamTutar INT NOT NULL,
	OlusturmaTarihi DATETIME NOT NULL DEFAULT GETDATE()
)
GO

/* REZERVASYON - OTEL OLANAKLARI */
CREATE TABLE Rezervasyon_OtelOlanaklari(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	RezervasyonId INT NOT NULL CONSTRAINT FK_Rezervasyon_OtelOlanaklari_Rezervasyon_RezervasyonId FOREIGN KEY (RezervasyonId) REFERENCES Rezervasyon(Id),
	OtelOlanaklariId INT NOT NULL CONSTRAINT FK_Rezervasyon_OtelOlanaklari_OtelOlanaklari_OtelOlanaklariId FOREIGN KEY (OtelOlanaklariId) REFERENCES OtelOlanaklari(Id),
	ToplamTutar INT NOT NULL,
	OlusturmaTarihi DATETIME NOT NULL DEFAULT GETDATE()
)
GO