USE OTEL
GO


-- 1 den fazla süperior tipi odası olan otellerin otel puanini 1 artir
UPDATE Otel
SET OtelPuani = OtelPuani + 1
WHERE Otel.Id IN (
		SELECT Oda.OtelId FROM Oda
			JOIN OdaTipi OT ON OT.Id = Oda.OdaTipiId
			WHERE OT.Ad = 'Süperior'
		GROUP BY Oda.OtelId, OT.Ad HAVING COUNT(OT.Ad) > 1
	)

-- google hotmail i satin aldi ve tum hotmail hesaplari kullanici isimleri ve dogum gunu gmail e  tasindi. bunun icin hotmail domainindeki mailleri gmail e gecirmeliyiz
-- [kullaniciadi@hotmail.com] --> [kullaniciadi-17@gmail.com]
UPDATE Musteri
SET Email = SUBSTRING(Email, 0, CHARINDEX('@', Email, 0)) +'-'+ DAY(DogumTarihi)+ '@gmail.com'
WHERE Email LIKE '%@hotmail.com'


-- otelin oda sayisini odalari kullanarak hesaplar
UPDATE Otel
SET Otel.OdaSayisi = O.OdaSayisi
FROM (SELECT OtelId, COUNT(OtelId) AS OdaSayisi FROM Oda GROUP BY OtelId) AS O
WHERE O.OtelId = Otel.Id


-- yalovadaki otellerde calisan 35 yasindan buyuk calisanlarin cikis tarihini guncelle yani isten cikar
UPDATE Otel_Calisan
SET CikisTarihi = GETDATE()
FROM Calisan C, Otel_Calisan OC, Otel O, Il
WHERE DATEDIFF(YEAR, DogumTarihi, GETDATE()) > 35 AND OC.CalisanId = C.Id AND OC.OtelId = O.Id AND O.IlId = Il.Id AND Il.Ad = 'Yalova'



