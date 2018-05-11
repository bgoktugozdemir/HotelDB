USE OTEL
GO

-- #1
-- hem rezervasyon yapip hem otelde kalan musterilerden, otelde kalan musterileri sil
DELETE FROM Rezervasyon_Musteri
WHERE MusteriId IN (
	SELECT RM.MusteriId AS MID FROM Rezervasyon_Musteri RM
	EXCEPT
	SELECT Rez.MusteriId AS MID FROM Rezervasyon Rez
)

-- #2
-- kullanilan otel olanaklarindan, 2015 ocak ve mayis aylari arasinda birden fazla fiyati olanlari siler
DELETE FROM Rezervasyon_OtelOlanaklari
WHERE Rezervasyon_OtelOlanaklari.OtelOlanaklariId IN (
	SELECT F.OtelOlanaklariId FROM OtelOlanaklari OO
	JOIN Fiyat F ON F.OtelOlanaklariId = OO.Id
	WHERE  F.BaslangicTarihi BETWEEN '2015-01-01' AND '2015-05-31'
	AND F.BitisTarihi BETWEEN '2015-01-01' AND '2015-05-31'
	GROUP BY F.OtelOlanaklariId HAVING COUNT(F.OtelOlanaklariId) > 1
)

-- #3
-- kullanilan ek hizmetlerden, ortalama kazanci 50 nin ustunde olan ek hizmetleri siler
DELETE FROM Rezervasyon_EkHizmet
WHERE Rezervasyon_EkHizmet.EkHizmetId IN (
	SELECT REK.EkHizmetId FROM Rezervasyon_EkHizmet REK
		GROUP BY REK.EkHizmetId HAVING SUM(REK.ToplamTutar) / COUNT(REK.ToplamTutar) > 50
)

-- #4
-- rezerve edilen odalardan, odanin bulundugu otelin ili yalova olanlari siler
DELETE FROM Rezervasyon_Oda
WHERE Rezervasyon_Oda.OdaId IN (
	SELECT Oda.Id FROM Oda
	JOIN Otel ON Otel.Id = Oda.OtelId
	JOIN Il ON Il.Id = Otel.IlId
	WHERE Il.Ad = 'Yalova'
)

-- #5
-- fiyatlardan, 2015 ocak ayindaki oda fiyatlarini siler
DELETE FROM Fiyat
WHERE (Fiyat.BaslangicTarihi BETWEEN '2015-01-01' AND '2015-03-31') AND Fiyat.OtelOlanaklariId IS NULL AND Fiyat.EkHizmetId IS NULL