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

-- oda tiplerinin verilen tarihler araliginda kac farkli fiyati oldugunu verir yani odanin fiyati kac defa degismis
SELECT OT.Ad AS Tipi, COUNT(*) FROM Fiyat
	JOIN OdaTipi AS OT ON OT.Id = Fiyat.OdaTipiId
WHERE 
	BaslangicTarihi BETWEEN '2017-06-01' AND '2018-06-01' 
AND
	BitisTarihi BETWEEN '2017-06-01' AND '2018-06-01'
GROUP BY OT.Ad

-- Verilen tarihler arasında en çok gelir elde edilen ek hizmetleri sıralar	//TODO: TAMAMLANACAK BG
SELECT EK.Ad, F.Deger FROM Rezervasyon R
	JOIN Rezervasyon_EkHizmet AS REK ON REK.RezervasyonId = R.Id
	JOIN EkHizmet AS EK ON EK.Id = REK.EkHizmetId
	JOIN Fiyat AS F ON F.EkHizmetId = EK.Id
WHERE 
	R.BaslangicTarihi BETWEEN '2018-01-01' AND '2019-01-01'
AND
	R.BitisTarihi BETWEEN '2018-01-01' AND '2019-01-01'
GROUP BY F.Deger, EK.Ad
ORDER BY F.Deger DESC

--  2018 Mart ayındaki rezervasyonlarda rez.süresi 2017 yılı ilk 3 aylık süreden daha uzun olan rezervasyonların bilgileri
SELECT DATEDIFF(DD, Rez.BaslangicTarihi, Rez.BitisTarihi) AS RezervasyonSuresi, Mus.Ad + ' ' + Mus.Soyad AS RezervasyonYapanMusteri FROM Rezervasyon Rez
JOIN Musteri Mus ON Mus.Id = Rez.MusteriId
	WHERE

	-- baslangic ve bitis tarihi 2018 mart ayinda olan rezervasyonlar
	Rez.BaslangicTarihi BETWEEN '2018-03-01' AND '2018-03-31' AND Rez.BitisTarihi BETWEEN '2018-01-01' AND '2018-03-31'	

	AND

	-- rezervasyon suresi, baslangic ve bitis tarihi 2017 ilk 3 ayda olan rezervasyonlarin suresinin her birinden buyuk olma kosulu
	DATEDIFF(DD, Rez.BaslangicTarihi, Rez.BitisTarihi) > ALL(

		-- baslangic ve bitis tarihi 2017 ilk 3 ayda olan rezervasyonlarin suresi
		SELECT DATEDIFF(DD, R.BaslangicTarihi, R.BitisTarihi) AS RezervasyonSuresi FROM Rezervasyon AS R WHERE R.BaslangicTarihi BETWEEN '2017-01-01' AND '2017-03-31' AND R.BitisTarihi BETWEEN '2017-01-01' AND '2017-03-31'
	)



-- Yıl, ay ve oda tipi bazında toplam fatura tutarı ve rezervasyon sayısı

	-- rezervasyondaki odalarin toplam fiyati
	SELECT SUM(F.Deger) FROM Oda O, OdaTipi OT, Rezervasyon_Oda RO, Rezervasyon Rez, Fiyat F
	WHERE O.OdaTipiId = OT.Id AND RO.OdaId = O.Id AND RO.RezervasyonId= Rez.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id

-- rezervasyonun fatura tutarı yani rezervasyondaki odalarin, ek hizmetlerin ve otel olanaklarin rezervasyonun baslangic tarihindeki fiyatlarinin toplami
SELECT ODAFIYAT.TOPLAMFIYAT + EKHIZMETFIYAT.TOPLAMFIYAT + OTELOLANAKLARIFIYAT.TOPLAMFIYAT AS TOPLAMFATURATUTARI FROM (
	-- rezervasyondaki odalarin toplam fiyati
	SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_Oda RO ON RO.RezervasyonId = Rez.Id
	JOIN Oda O ON O.Id = RO.OdaId
	JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
	JOIN Fiyat F ON F.OdaTipiId = OT.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id) AS ODAFIYAT,

	-- rezervasyondaki ek hizmetlerin toplam fiyati
	(SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_EkHizmet REK ON REK.RezervasyonId = Rez.Id
	JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId
	JOIN Fiyat F ON F.EkHizmetId = EK.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id) AS EKHIZMETFIYAT,

	-- rezervasyondaki otel olanaklarinin toplam fiyati
	(SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_OtelOlanaklari ROO ON ROO.RezervasyonId = Rez.Id
	JOIN OtelOlanaklari OO ON OO.Id = ROO.OtelOlanaklariId
	JOIN Fiyat F ON F.EkHizmetId = OO.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id) AS OTELOLANAKLARIFIYAT





	SELECT * FROM Rezervasyon WHERE Id = 1
	SELECT * FROM Rezervasyon_Oda WHERE RezervasyonId = 1
	SELECT * FROM Oda WHERE Id = 1
	SELECT * FROM OdaTipi WHERE Id = 2
	SELECT * FROM Fiyat WHERE OdaTipiId = 2 AND '2018-04-21' BETWEEN BaslangicTarihi AND BitisTarihi

SELECT OT.Ad, F.Deger FROM Oda O, OdaTipi OT, Rezervasyon_Oda RO, Rezervasyon Rez, Fiyat F
WHERE O.OdaTipiId = OT.Id AND RO.OdaId = O.Id AND RO.RezervasyonId= Rez.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi