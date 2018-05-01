USE OTEL
GO

/* ek hizmetleri fiyatlariyla yazar */
SELECT EK.Ad, Fiyat.Deger FROM Fiyat
	JOIN EkHizmet AS EK ON EK.Id = Fiyat.EkHizmetId
WHERE BaslangicTarihi < '2018-06-01'

/* otel olanaklarini fiyatlariyla yazar */
SELECT OO.Ad, Fiyat.Deger FROM Fiyat
	JOIN OtelOlanaklari AS OO ON OO.Id = Fiyat.OtelOlanaklariId
WHERE BaslangicTarihi < '2018-06-01'

/* oda tiplerini fiyatlariyla yazar */
SELECT OT.Ad AS Tipi, Fiyat.Deger AS Fiyat FROM Fiyat
	JOIN OdaTipi AS OT ON OT.Id = Fiyat.OdaTipiId
WHERE BaslangicTarihi < '2018-06-01'