DROP PROCEDURE IF EXISTS dbo.spMusteriEkle
GO

-- musteri ekler, eger id verilirse verilen id ye eklemeye calisir
CREATE PROCEDURE dbo.spMusteriEkle @kimlikNo CHAR(11), @ad NVARCHAR(30), @soyad NVARCHAR(30), @telefonNumarasi VARCHAR(13), @email VARCHAR(256), @dogumtarihi DATE, @cinsiyet CHAR(1), @Id INT = NULL
AS
BEGIN
	BEGIN TRANSACTION
	IF @Id IS NULL
		BEGIN
			INSERT INTO dbo.Musteri (KimlikNo, Ad, Soyad, TelefonNumarasi, Email, DogumTarihi, Cinsiyet)
			VALUES (@kimlikNo, @ad, @soyad, @telefonNumarasi, @email, @dogumtarihi, @cinsiyet)
			COMMIT
		END
	ELSE
		BEGIN
			SET IDENTITY_INSERT dbo.Musteri ON
			
			BEGIN TRY
			
				INSERT INTO dbo.Musteri (Id, KimlikNo, Ad, Soyad, TelefonNumarasi, Email, DogumTarihi, Cinsiyet)
				VALUES (@Id, @kimlikNo, @ad, @soyad, @telefonNumarasi, @email, @dogumtarihi, @cinsiyet)
			END TRY
			BEGIN CATCH
				PRINT 'Eklenemedi, transaction basina donuluyor!'
				ROLLBACK
			END CATCH
			
			SET IDENTITY_INSERT dbo.Musteri OFF
			
			COMMIT
		END
END
GO
EXEC dbo.spMusteriEkle 10000000000, 'Turkalp', 'Kayranci', '5220000000', 'bkayranci@gmail.com', '1997-05-17', 'E', 107
SELECT * FROM dbo.Musteri WHERE Id = 107 -- kontrol amacli
GO
DROP PROCEDURE IF EXISTS dbo.spMusteriGuncelle
GO
-- musteri id ile secilen musteriyi gunceller
CREATE PROCEDURE dbo.spMusteriGuncelle @musteriId INT, @kimlikNo CHAR(11), @ad NVARCHAR(30), @soyad NVARCHAR(30), @telefonNumarasi VARCHAR(13), @email VARCHAR(256), @dogumtarihi DATE, @cinsiyet CHAR(1)
AS
BEGIN
	UPDATE dbo.Musteri
	SET
		KimlikNo = @kimlikNo,
		Ad = @ad,
		Soyad = @soyad,
		TelefonNumarasi = @telefonNumarasi,
		Email = @email,
		DogumTarihi = @dogumtarihi,
		Cinsiyet = @cinsiyet
	WHERE Id = @musteriId
END
GO
EXEC dbo.spMusteriGuncelle 107, 20000000000, 'Burak', 'Kayrancioglu', '3220000000', 'turkalp@mail.com', '1990-05-17', 'E'
SELECT * FROM dbo.Musteri WHERE Id = 107 -- kontrol amacli
GO
DROP PROCEDURE IF EXISTS dbo.spMusteriSil
GO
-- musteri id ile secilen musteriyi siler
CREATE PROCEDURE dbo.spMusteriSil @musteriId INT
AS
BEGIN
	DELETE FROM dbo.Musteri
	WHERE Id = @musteriId
END
GO
EXEC dbo.spMusteriSil 107
SELECT * FROM dbo.Musteri WHERE Id = 107 -- kontrol amacli
GO
DROP PROCEDURE IF EXISTS dbo.spCursorExample
GO
CREATE PROCEDURE dbo.spCursorExample
AS
BEGIN
	DECLARE c1 CURSOR FOR SELECT Id, Ad, Soyad FROM dbo.Musteri
	DECLARE @Id INT, @Ad VARCHAR(MAX), @Soyad VARCHAR(MAX)
	OPEN c1
	
	FETCH NEXT FROM c1 INTO @Id, @Ad, @Soyad
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT(@Id, ' ', @Ad, ' ', @Soyad)
		FETCH NEXT FROM c1 INTO @Id, @Ad, @Soyad
	END
	
	CLOSE c1
	DEALLOCATE c1
	
END
GO
EXEC dbo.spCursorExample
GO
DROP PROCEDURE IF EXISTS dbo.spSec
GO
-- musteri id ile secilen musteriyi gunceller
CREATE PROCEDURE dbo.spSec @musteriId INT
AS
BEGIN
	SELECT * FROM dbo.Musteri WHERE Id = @musteriId
END
GO
EXEC dbo.spSec 50


