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

-- oda tiplerinin verilen tarihler araliginda kac farkli fiyati oldugunu verir yani odanin fiyati kac defa degismis ve o odatipinin guncel fiyati
SELECT OT.Ad AS [Oda Tipi], COUNT(OT.Ad) AS [Kac Defa], AVG(F.Deger) AS [Fiyat Ortalaması], GUNCELFIYAT.Deger AS [Güncel Fiyat] FROM Fiyat F
	JOIN OdaTipi AS OT ON OT.Id = F.OdaTipiId
	JOIN (SELECT OT2.Id AS OId, F2.Deger FROM Fiyat F2
			JOIN OdaTipi OT2 ON OT2.Id = F2.OdaTipiId
			WHERE
				GETDATE() BETWEEN F2.BaslangicTarihi AND F2.BitisTarihi) AS GUNCELFIYAT ON GUNCELFIYAT.OId = OT.Id
WHERE 
	F.BaslangicTarihi BETWEEN '2017-06-01' AND '2018-06-01' 
AND
	F.BitisTarihi BETWEEN '2017-06-01' AND '2018-06-01'
GROUP BY OT.Ad, GUNCELFIYAT.Deger
																														


-- bitmedi
--  2018 Mart ayındaki rezervasyonlarda rez.süresi 2017 yılı ilk 3 aylık süreden daha uzun olan rezervasyonların bilgileri
SELECT DATEDIFF(DD, Rez.BaslangicTarihi, Rez.BitisTarihi) AS RezervasyonSuresi, Mus.Ad + ' ' + Mus.Soyad AS RezervasyonYapanMusteri FROM Rezervasyon Rez
JOIN Musteri Mus ON Mus.Id = Rez.MusteriId
	WHERE

	-- baslangic ve bitis tarihi 2018 mart ayinda olan rezervasyonlar
	(Rez.BaslangicTarihi BETWEEN '2018-03-01' AND '2018-03-31') AND (Rez.BitisTarihi BETWEEN '2018-01-01' AND '2018-03-31')

	AND

	-- ortalama sure yap
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
SELECT TUMTOPLAMLAR.RezId, SUM(TUMTOPLAMLAR.TOPLAMFIYAT) AS TOPLAMFATURATUTARI FROM (
	-- rezervasyondaki odalarin toplam tutari
	SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_Oda RO ON RO.RezervasyonId = Rez.Id
	JOIN Oda O ON O.Id = RO.OdaId
	JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
	JOIN Fiyat F ON F.OdaTipiId = OT.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id

	UNION
	
	-- rezervasyondaki ek hizmetlerin toplam tutari
	SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_EkHizmet REK ON REK.RezervasyonId = Rez.Id
	JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId
	JOIN Fiyat F ON F.EkHizmetId = EK.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id

	UNION

	-- otel olanagını ekleme sadece kullanılırken odeme yapılsın
	-- rezervasyondaki otel olanaklarinin toplam tutari
	SELECT Rez.Id AS RezId, SUM(F.Deger) AS TOPLAMFIYAT FROM Rezervasyon Rez
	JOIN Rezervasyon_OtelOlanaklari ROO ON ROO.RezervasyonId = Rez.Id
	JOIN OtelOlanaklari OO ON OO.Id = ROO.OtelOlanaklariId
	JOIN Fiyat F ON F.EkHizmetId = OO.Id AND Rez.BaslangicTarihi BETWEEN F.BaslangicTarihi AND F.BitisTarihi
	GROUP BY Rez.Id) AS TUMTOPLAMLAR
GROUP BY TUMTOPLAMLAR.RezId


-- bitmedi
-- ## V2 ## rezervasyonun fatura tutarı yani rezervasyondaki odalarin, ek hizmetlerin ve otel olanaklarin rezervasyonun baslangic tarihindeki fiyatlarinin toplami
SELECT TUMTABLO.Id, SUM(TUMTABLO.TOPLAMTUTAR) AS TOPLAMFATURATUTARI FROM
(SELECT Rez.Id, SUM(REK.ToplamTutar) AS TOPLAMTUTAR FROM Rezervasyon Rez
	JOIN Rezervasyon_EkHizmet REK ON REK.RezervasyonId = Rez.Id
	GROUP BY Rez.Id
UNION
SELECT Rez.Id, SUM(ROO.ToplamTutar) AS TOPLAMTUTAR FROM Rezervasyon Rez
	JOIN Rezervasyon_OtelOlanaklari ROO ON ROO.RezervasyonId = Rez.Id
	GROUP BY Rez.Id
UNION
SELECT Rez.Id, SUM(RO.ToplamTutar) AS TOPLAMTUTAR FROM Rezervasyon Rez
	JOIN Rezervasyon_Oda RO ON RO.RezervasyonId = Rez.Id
	GROUP BY Rez.Id
) AS TUMTABLO
GROUP BY TUMTABLO.Id
	

-- ek hizmetten elde edilen gelirin buyukten kucuge sırala her ek hizmetten gelen gelirin ortalaması
SELECT EK.Ad, SUM(REK.ToplamTutar) AS TOPLAMTUTAR, COUNT(REK.EkHizmetId) [Kac Defa Kullanilmis], (SUM(REK.ToplamTutar)/COUNT(REK.ToplamTutar)) AS ORT
FROM Rezervasyon_EkHizmet REK
	JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId
WHERE REK.OlusturmaTarihi BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY EK.Ad
ORDER BY TOPLAMTUTAR DESC



	-- kontrol
	SELECT * FROM Rezervasyon WHERE Id = 1
	
	-- rezervasyon
	SELECT * FROM Rezervasyon_Oda WHERE RezervasyonId = 1
	SELECT * FROM Oda WHERE Id = 1 OR Id = 44
	SELECT * FROM OdaTipi WHERE Id = 2
	SELECT * FROM Fiyat WHERE OdaTipiId = 2 AND '2018-04-21' BETWEEN BaslangicTarihi AND BitisTarihi

	-- ek hizmet
	SELECT * FROM Rezervasyon_EkHizmet WHERE RezervasyonId = 1
	SELECT * FROM EkHizmet WHERE Id = 1
	SELECT * FROM Fiyat WHERE EkHizmetId = 1 AND '2018-04-21' BETWEEN BaslangicTarihi AND BitisTarihi

	-- otel olanaklari
	SELECT * FROM Rezervasyon_OtelOlanaklari WHERE RezervasyonId = 1
	SELECT * FROM OtelOlanaklari WHERE Id = 1
	SELECT * FROM Fiyat WHERE OtelOlanaklariId = 1 AND '2018-04-21' BETWEEN BaslangicTarihi AND BitisTarihi

	select * from Rezervasyon_EkHizmet


-- Yıllara göre otelde kalan erkek/kadın sayısı
SELECT YEAR(Rez.BaslangicTarihi) AS [YIL], M.Cinsiyet, COUNT(M.Cinsiyet) AS [Kaç Kişi] FROM Rezervasyon_Musteri RM
	JOIN  Musteri M ON RM.MusteriId = M.Id
	JOIN Rezervasyon Rez ON Rez.Id = RM.RezervasyonId
WHERE Rez.SilinmeTarihi IS NULL
GROUP BY M.Cinsiyet, YEAR(Rez.BaslangicTarihi)
ORDER BY YIL DESC, M.Cinsiyet DESC



