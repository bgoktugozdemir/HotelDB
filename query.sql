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


-- #4 @verilen sorgu
-- Yıl, ay ve oda tipi bazında toplam fatura tutarı ve rezervasyon sayısı
SELECT YEAR(RO.OlusturmaTarihi) AS [Yıl], MONTH(RO.OlusturmaTarihi) AS [Ay], OT.Ad AS [Oda Tipi], SUM(RO.ToplamTutar) AS [Fatura Tutarı], COUNT(OT.Ad) AS [Kaç Tane] FROM Rezervasyon Rez
	JOIN Rezervasyon_Oda RO ON RO.Id = Rez.Id
	JOIN Oda O ON O.Id = RO.OdaId
	JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
GROUP BY YEAR(RO.OlusturmaTarihi), MONTH(RO.OlusturmaTarihi), OT.Ad


-- #5 @verilen sorgu
-- 2018 Mart ayındaki rezervasyonlarda rez.süresi 2017 yılı ilk 3 aylık süreden daha uzun olan rezervasyonların bilgileri
SELECT DATEDIFF(DD, Rez.BaslangicTarihi, Rez.BitisTarihi) AS RezervasyonSuresi, Mus.Ad + ' ' + Mus.Soyad AS RezervasyonYapanMusteri, Rez.BaslangicTarihi AS [Rezervasyon Başlangıç Tarihi], Rez.BitisTarihi AS [Rezervasyon Bitiş Tarihi] FROM Rezervasyon Rez
	JOIN Musteri Mus ON Mus.Id = Rez.MusteriId
	WHERE

	-- baslangic ve bitis tarihi 2018 mart ayinda olan rezervasyonlar
	(Rez.BaslangicTarihi BETWEEN '2018-03-01' AND '2018-03-31') AND (Rez.BitisTarihi BETWEEN '2018-01-01' AND '2018-03-31')
	AND

	-- rezervasyon suresi, baslangic ve bitis tarihi 2017 ilk 3 ayda olan rezervasyonlarin suresinin her birinden buyuk olma kosulu
	DATEDIFF(DD, Rez.BaslangicTarihi, Rez.BitisTarihi) > 

		-- baslangic ve bitis tarihi 2017 ilk 3 ayda olan rezervasyonlarin suresinin ortalamasi
		(SELECT AVG(DATEDIFF(DD, R.BaslangicTarihi, R.BitisTarihi)) AS RezervasyonSuresiOrtalamasi FROM Rezervasyon AS R WHERE R.BaslangicTarihi BETWEEN '2017-01-01' AND '2017-03-31' AND R.BitisTarihi BETWEEN '2017-01-01' AND '2017-03-31')