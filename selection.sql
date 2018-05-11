USE OTEL
GO

-- #1
-- AMAC: Bir odanin fiyatinin belirli tarihlerdeki fiyat ortalamasi ve guncel fiyat ortalamasina bakarak bu odayi kiralamanin mantikli olup olmayacagi gorulebilir.
/*
	Oda tiplerinin verilen tarihler araliginda kac farkli
	fiyati oldugunu ve o odatipinin guncel fiyatini verir.
	Bize oda tipinin adina gore a'dan z'ye sirali olarak getirir.
*/
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
ORDER BY OT.Ad ASC

-- #2
-- AMAC: Otel sahibi için fazla kazandiran hizmetler uzerine yatirim yapip daha fazla kazanc elde etmek ve hizmetlerin fiyatlarini, ortalama fiyattan hizli bir yukselis yapacak sekilde yukselterek, musterilerin bu hizmetleri alamamasini engellemeye yonelik kullanilabilir.
/*
	Bir ekhizmetin belirli tarihler arasindaki kazandirdigi toplam tutar,
	bu hizmetin kac defa kullanildigi ve bu hizmetin ortalama fiyatini verir.
	Bize toplam tutara gore buyukten kucuge sirali olarak getirir.
*/
SELECT EK.Ad, SUM(REK.ToplamTutar) AS [Toplam Tutar], COUNT(REK.EkHizmetId) [Kac Defa Kullanilmis], (SUM(REK.ToplamTutar)/COUNT(REK.ToplamTutar)) AS [Ortalama Fiyati]
FROM Rezervasyon_EkHizmet REK
	JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId
WHERE REK.OlusturmaTarihi BETWEEN '2018-01-01' AND '2018-12-31'
GROUP BY EK.Ad
ORDER BY [Toplam Tutar] DESC


-- #3
-- AMAC: Otel sahibi icin otellerde kalan musterilerinin sayisini cinsiyet ve yil bazli goruntuleyebilir. Ornegin, otelleri erkekler daha fazla tercih ediyorsa otelini erkekler icin tasarlayarak musteri memnuniyetini artirir, ayrica musteri cekmek icin yapacagi reklam kitlesini de bu sekilde belirleyebilir.
/*
	Otellerde kalan musterilerin sayisini cinsiyet ve yil bazli olarak goruntuler.
*/
SELECT YEAR(Rez.BaslangicTarihi) AS [YIL], M.Cinsiyet, COUNT(M.Cinsiyet) AS [Kaç Kişi] FROM Rezervasyon_Musteri RM
	JOIN  Musteri M ON RM.MusteriId = M.Id
	JOIN Rezervasyon Rez ON Rez.Id = RM.RezervasyonId
WHERE Rez.SilinmeTarihi IS NULL
GROUP BY M.Cinsiyet, YEAR(Rez.BaslangicTarihi)
ORDER BY YIL DESC, M.Cinsiyet DESC





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
	