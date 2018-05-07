USE OTEL
GO

/* ek hizmetleri fiyatlariyla yazar */
SELECT EK.Ad, Fiyat.Deger FROM Fiyat
	JOIN EkHizmet AS EK ON EK.Id = Fiyat.EkHizmetId
WHERE BaslangicTarihi < '2018-06-01'

/* otel olanaklarini fiyatlariyla yazar */
SELECT OO.Ad, Fiyat.Deger FROM Fiyat
	JOIN OtelOlanaklari AS OO ON OO.Id = Fiyat.OtelOlanaklariId
WHERE BaslangicTarihi < '2019-06-01'

/* oda tiplerinin verilen tarihler araliginda kac farkli fiyati oldugunu verir yani odanin fiyati kac defa degismis */
SELECT OT.Ad AS Tipi, COUNT(*) FROM Fiyat
	JOIN OdaTipi AS OT ON OT.Id = Fiyat.OdaTipiId
WHERE 
	BaslangicTarihi BETWEEN '2017-06-01' AND '2018-06-01' 
AND
	BitisTarihi BETWEEN '2017-06-01' AND '2018-06-01'
GROUP BY OT.Ad
