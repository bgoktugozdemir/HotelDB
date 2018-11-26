DROP FUNCTION dbo.fncBosOdalarTablosu

CREATE FUNCTION fncBosOdalarTablosu (@BaslangicTarihi DATE, @BitisTarihi DATE)
RETURNS @BosOdalar TABLE(
	OdaID INT, --Oda ID
	OtelID INT, --Otel ID
	OdaTipiID INT, --Oda Tipi ID
	EkHizmetID INT, --Oda Bilgileri
	Kapasite TINYINT, --Kapasite
	OdaFiyat MONEY --Fiyat

	PRIMARY KEY(OdaID, OtelID, OdaTipiID, EkHizmetID)
)
AS
	BEGIN
		INSERT INTO @BosOdalar

		SELECT O.Id, O.OtelId, OT.Id, OE.EkHizmetId, O.Kapasite, F.Deger
		FROM Oda O
			INNER JOIN Oda_EkHizmet OE ON O.Id = OE.OdaId
			INNER JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
			INNER JOIN Fiyat F ON OT.Id = F.OdaTipiId
		WHERE O.Id NOT IN(
			SELECT OdaId
			FROM Rezervasyon_Oda RO
				INNER JOIN Rezervasyon R ON RO.RezervasyonId = R.Id
			WHERE	(BaslangicTarihi BETWEEN @BaslangicTarihi AND @BitisTarihi) OR
					(BitisTarihi BETWEEN @BaslangicTarihi AND @BitisTarihi) AND O.Id = RO.OdaId
		)
		RETURN
	END
GO

SELECT * FROM dbo.fncBosOdalarTablosu('2016-01-01','2016-12-31')

SELECT O.Id, O.OtelId, OT.Id, OE.EkHizmetId, O.Kapasite, F.Deger
FROM Oda O
	INNER JOIN Oda_EkHizmet OE ON O.Id = OE.OdaId
	INNER JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
	LEFT JOIN Fiyat F ON OT.Id = F.OdaTipiId
WHERE O.Id NOT IN(
	SELECT OdaId
	FROM Rezervasyon_Oda RO
		INNER JOIN Rezervasyon R ON RO.RezervasyonId = R.Id
	WHERE	(BaslangicTarihi BETWEEN '2016-01-01' AND '2016-12-31') OR
			(BitisTarihi BETWEEN '2016-01-01' AND '2016-12-31') AND O.Id = RO.OdaId
)