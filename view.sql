CREATE VIEW vOdalar
AS
	SELECT	OTEL.Ad AS [Otel Adı],
			O.Id AS [Oda ID],
			OT.Ad AS [Oda Tipi],
			O.Kapasite AS [Oda Kapasitesi],
			F.Deger AS [Oda Ücreti ₺],
			RO.ToplamTutar AS [Ödenen Oda Ücreti ₺],
			REK.ToplamTutar AS [Ödenen Ek Hizmet Ücreti ₺],
			CASE
				WHEN RO.RezervasyonId = NULL THEN 'BOŞ'
				ELSE M.Ad + ' ' + M.Soyad
			END AS [Oda Sahibi],
			R.BaslangicTarihi AS [Rezervasyon Başlangıç Tarihi],
			R.BitisTarihi AS [Rezervasyon Bitiş Tarihi],
			RO.OlusturmaTarihi AS [Rezervasyon Oluşturulma Tarihi],
			R.SilinmeTarihi AS [Rezervasyon Silinme Tarihi],
			ISNULL(EK.Ad, '-') AS [Ek Hizmet Adı]
				
	FROM Oda O
		INNER JOIN Rezervasyon_Oda RO ON RO.OdaId = O.Id
		INNER JOIN Rezervasyon R ON R.Id = RO.RezervasyonId
		INNER JOIN Rezervasyon_Musteri RM ON RM.RezervasyonId = R.Id
		INNER JOIN Musteri M ON M.Id = RM.MusteriId
		INNER JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
		INNER JOIN Otel OTEL ON OTEL.Id = O.OtelId
		INNER JOIN Oda_EkHizmet OEK ON OEK.OdaId = O.Id
		INNER JOIN Rezervasyon_EkHizmet REK ON REK.RezervasyonId = R.Id
		LEFT JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId OR EK.Id = OEK.EkHizmetId --OEK EkHizmetId de aynı satıra eklenmeli
		INNER JOIN Fiyat F ON F.OdaTipiId = OT.Id
GO

	SELECT *
	FROM Oda O
		INNER JOIN Rezervasyon_Oda RO ON RO.OdaId = O.Id
		INNER JOIN Rezervasyon R ON R.ID = RO.RezervasyonId
		INNER JOIN Rezervasyon_Musteri RM ON RM.RezervasyonId = R.Id
		INNER JOIN Musteri M ON M.Id = RM.MusteriId
		INNER JOIN OdaTipi OT ON OT.Id = O.OdaTipiId
		INNER JOIN Otel OTEL ON OTEL.Id = O.OtelId
		INNER JOIN Oda_EkHizmet OEK ON OEK.OdaId = O.Id
		INNER JOIN Rezervasyon_EkHizmet REK ON REK.RezervasyonId = R.Id
		INNER JOIN EkHizmet EK ON EK.Id = REK.EkHizmetId
		INNER JOIN Fiyat F ON F.OdaTipiId = OT.Id

		SELECT *
		FROM Rezervasyon