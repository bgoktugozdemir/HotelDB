-- OdaID, OdaTipiID, Kapasite, OdaTipi, FiyatID, Fiyat ve FiyatDegisimineKalanGun sutunlarini o gunku tarih araligina denk gelen fiyat icin gosterir
DROP VIEW IF EXISTS dbo.vwOdaFiyat
GO
CREATE VIEW vwOdaFiyat
AS
SELECT O.Id OdaID, OT.Id OdaTipiID, O.Kapasite Kapasite, OT.Ad OdaTipi, F.ID FiyatID, F.Deger Fiyat, DATEDIFF(dd, GETDATE(), F.BitisTarihi) AS FiyatDegisimineKalanGun FROM dbo.Oda O
	JOIN dbo.OdaTipi OT ON O.OdaTipiId = OT.Id
	JOIN dbo.Fiyat F ON F.OdaTipiId = OT.Id
WHERE
	F.OdaTipiId IS NOT NULL AND
	GETDATE() BETWEEN F.BaslangicTarihi AND F.BitisTarihi

GO
-- rezervasyondaki toplam tutari suanki oda fiyatindan yuksek olanlara daha dusuk fiyatla yeniden rezerve etmeyi haber vermek icin rezervasyon yapan musterinin bilgilerini getirir
SELECT M.Id, M.Ad, M.Soyad, M.Cinsiyet, M.Email, M.KimlikNo, M.TelefonNumarasi, M.DogumTarihi FROM dbo.vwOdaFiyat O
	JOIN dbo.Rezervasyon_Oda RO ON RO.OdaId = O.OdaID
	JOIN dbo.Rezervasyon_Musteri RM ON RM.RezervasyonId = RO.RezervasyonId 
	JOIN dbo.Musteri M ON M.Id = RM.MusteriId
WHERE
	O.Fiyat < RO.ToplamTutar