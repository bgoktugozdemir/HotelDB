USE OTEL
GO

INSERT INTO OtelOlanaklari VALUES
	('Mescid'),
	('SPA'),
	('Golf'),
	('Havuz'),
	('Hamam'),
	('Masaj'),
	('Spor Salonu'),
	('Disko'),
	('Bar'),
	('Yemek Salonu');

INSERT INTO Il VALUES
	('Ýstanbul'),
	('Ýzmir'),
	('Ankara'),
	('Mardin'),
	('Hakkari'),
	('Antalya'),
	('Trabzon'),
	('Samsun'),
	('Diyarbakýr'),
	('Yalova');

INSERT INTO Calisan(
	KimlikNo, Cinsiyet, TelefonNumarasi, Ad, Soyad, DogumTarihi, Email
) VALUES
	('12345678901', 'E', '5357654321', 'Türkalp', 'Kayrancý', '1997-05-17', 'bkayranci@gmail.com'),
	('12345678902', 'K', '5357654322', 'Ayþe'	, 'Düzgiden', '1988-04-21', 'duzgidenayse@gmail.com'),
	('12345678903', 'D', '5357654323', 'Deniz'	, 'Görmüþ', '1992-09-28', 'gormusdeniz@gmail.com'),
	('12345678904', 'E', '5357654324', 'Göktuð'	, 'Özdemir', '1997-07-16', 'bgoktugozdemir@gmail.com'),
	('12345678905', 'K', '5357654325', 'Edanur'	, 'Özdemir', '1997-01-22', 'ozdemireda@gmail.com'),
	('12345678906', 'E', '5357654326', 'Ümit'	, 'Küçük', '1997-01-19', 'umitkucuk@gmail.com'),
	('12345678907', 'E', '5357654327', 'Hakan'	, 'Kösdað', '1997-09-20', 'hakankosdag@gmail.com'),
	('12345678908', 'K', '5357654328', 'Hayriye', 'Kasapçý', '1991-09-17', 'kasapciii@gmail.com'),
	('12345678909', 'D', '5357654329', 'Fatih'	, 'Teksoy', '1991-05-17', 'asdasd@gmail.com'),
	('12345678910', 'E', '5357654310', 'Fatih'	, 'Termin', '1983-05-17', 'fasfasdsad@gmail.com');

INSERT INTO Musteri (
	KimlikNo, Cinsiyet, TelefonNumarasi, Ad, Soyad, DogumTarihi, Email
) VALUES
	('12345678901', 'E', '5347654321', 'Türkalp', 'Kayrancý'	, '1997-05-17', 'hdksadnalsdnas@gmail.com'),
	('12345678902', 'K', '5347654322', 'Ayþe'	, 'Düzgiden'	, '1988-04-21', null),
	('12345678903', 'D', '5347654323', 'Deniz'	, 'Görmüþ'		, '1992-09-28', null),
	('12345678904', 'E', '5347654324', 'Göktuð'	, 'Özdemir'		, '1997-07-16', 'kkkk@gmail.com'),
	('12345678905', 'K', '5347654325', 'Edanur'	, 'Özdemir'		, '1997-01-22', null),
	('12345678906', 'E', '5347654326', 'Ümit'	, 'Küçük'		, '1997-01-19', 'asdsad@gmail.com'),
	('12345678907', 'E', '5347654327', 'Hakan'	, 'Kösdað'		, '1997-09-20', null),
	('12345678908', 'K', '5347654328', 'Hayriye', 'Kasapçý'		, '1991-09-17', '1234@gmail.com'),
	('12345678909', 'D', '5347654329', 'Fatih'	, 'Teksoy'		, '1991-05-17', null),
	('12345678910', 'E', '5347654310', 'Fatih'	, 'Termin'		, '1983-05-17', null);

INSERT INTO EkHizmet(
	Ad
) VALUES 
	('Oda Servisi'),
	('Oda Kahvaltý'),
	('Uyandýrma Servisi'),
	('Çocuk Yataðý'),
	('Minibar');

INSERT INTO Rezervasyon(
	BaslangicTarihi, BitisTarihi, CikisTarihi, SilinmeTarihi, MusteriId
) VALUES
	('2018-04-21', '2018-04-27', '2018-04-27', NULL, 3),
	('2018-03-18', '2018-03-23', '2018-03-23', NULL, 2),
	('2018-01-03', '2018-01-05', '2018-01-05', NULL, 1),
	('2018-04-29', '2018-05-02', NULL, NULL, 4),
	('2018-02-25', '2018-02-26', '2018-02-26', NULL, 5),
	('2018-03-09', '2018-03-18', '2018-03-18', NULL, 7),
	('2018-04-26', '2018-05-03', NULL, NULL, 6),
	('2018-07-01', '2018-07-04', NULL, NULL, 8),
	('2018-09-09', '2018-09-14', NULL, '2018-04-28', 9),
	('2018-06-10', '2018-06-24', NULL, '2018-04-19', 10);

INSERT INTO OdaTipi(
	Ad
) VALUES 
	('Suit'),
	('Çift Kiþilik'),
	('Tek Kiþilik'),
	('VIP'),
	('Kral Dairesi');

INSERT INTO Ilce(
	 Ad, IlId
) VALUES
	('Merkez', 1),
	('Merkez', 2),
	('Merkez', 3),
	('Merkez', 4),
	('Merkez', 5),
	('Merkez', 6),
	('Merkez', 7),
	('Merkez', 8),
	('Merkez', 9),
	('Merkez', 10),
	('Termal', 10);

INSERT INTO Otel (
	Ad, Telefon, Adres, Email, OtelPuan, OtelYildiz, IlId, IlceId 
) VALUES
	('Termal Otel', '5554443322', 'Gökçedere Mahallesi Lale Sokak No: 3', 'mail@termalotel.com', 3, 5, 1, 1),
	('Termal Otel 2', '5554443323', 'Nergis Mahallesi Lale Sokak No: 3', 'mail2@termalotel.com', 2.5, 3, 1, 1),
	('Termal Otel', '5554443322', 'Asma Mahallesi Lale Sokak No: 3', 'mail3@termalotel.com', 4, 5, 1, 1),
	('Termal Otel', '5554443322', 'Kadir Mahallesi Lale Sokak No: 3', 'mail4@termalotel.com', 3, 2, 1, 1),
	('Termal Otel', '5554443322', 'Selfie Mahallesi Lale Sokak No: 3', 'mail5@termalotel.com', 3, 4, 1, 1),
	('Termal Otel', '5554443322', 'Deniz Mahallesi Lale Sokak No: 3', 'mail6@termalotel.com', 3, 4, 1, 1),
	('Termal Otel', '5554443322', 'Baðlarbaþý Mahallesi Lale Sokak No: 3', 'mail7@termalotel.com', 3, 1, 1, 1),
	('Termal Otel', '5554443322', 'Safranyolu Mahallesi Lale Sokak No: 3', 'mail8@termalotel.com', 3, 0, 1, 1),
	('Termal Otel', '5554443322', 'Tigem Mahallesi Lale Sokak No: 3', 'mail9@termalotel.com', 3, 5, 1, 1),
	('Termal Otel', '5554443322', 'Bornoz Mahallesi Lale Sokak No: 3', 'mail10@termalotel.com', 3, 4, 1, 1),
	('Termal Otel', '5554443322', 'Sabuncu Mahallesi Lale Sokak No: 3', 'mail11@termalotel.com', 3, 3, 1, 1),
	('Termal Otel', '5554443322', 'Çam Mahallesi Lale Sokak No: 3', 'mail12@termalotel.com', 3, 2, 1, 1);

INSERT INTO Oda (
	Kapasite, OtelId, OdaTipiId
) VALUES
	('4', 1, 1),
	('2', 1, 2),
	('3', 1, 5),
	('4', 1, 4),
	('1', 1, 3),
	('1', 2, 3),
	('4', 2, 1),
	('3', 2, 5),
	('2', 2, 2),
	('4', 2, 4);


INSERT INTO Fiyat (
	Deger, BaslangicTarihi, BitisTarihi, OtelOlanaklariId, OdaTipiId, EkHizmetId 
) VALUES
	(25, '2018-04-21', '2018-04-27', NULL, NULL, 3),
	(250, '2018-03-18', '2018-03-23', NULL, NULL, 3),
	(285, '2018-01-03', '2018-01-05', NULL, NULL, 3),
	(653, '2018-04-29', '2018-05-02', NULL, NULL, 3),
	(880, '2018-02-25', '2018-02-26', NULL, NULL, 3),
	(220, '2018-03-09', '2018-03-18', NULL, NULL, 3),
	(1630, '2018-04-26', '2018-05-03', NULL, NULL, 3),
	(700, '2018-07-01', '2018-07-04', NULL, NULL, 3),
	(1200, '2018-09-09', '2018-09-14', NULL, NULL, 3),
	(3840, '2018-06-10', '2018-06-24', NULL, NULL, 3);

INSERT INTO Otel_Olanaklar (
	OtelId, OlanakId
) VALUES
	(1,1),
	(1,4),
	(2,2),
	(2,3),
	(3,2),
	(4,5),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10);

INSERT INTO Otel_Calisan (
	OtelId, CalisanId, Maas, BaslangicTarihi, CikisTarihi, SilinmeTarihi
) VALUES
	(1, 1, 1650, '2018-01-01', NULL, NULL),
	(2, 2, 1650, '2018-01-01', NULL, NULL),
	(3, 3, 1650, '2018-01-01', '2018-04-18', NULL),
	(3, 4, 1650, '2018-01-01', NULL, NULL),
	(4, 5, 1650, '2018-01-01', NULL, NULL),
	(5, 6, 1650, '2018-01-01', NULL, NULL),
	(6, 7, 1650, '2018-01-01', NULL, NULL),
	(7, 8, 1650, '2018-01-01', NULL, NULL),
	(8, 9, 1650, '2018-01-01', NULL, NULL),
	(9, 10, 1650, '2018-01-01', NULL, NULL);

INSERT INTO EkHizmet_Oda (
	EkHizmetId, OdaId
) VALUES
	(1,1),
	(2,1),
	(3,1),
	(4,1),
	(5,1),
	(1,6),
	(2,7),
	(3,8),
	(4,9),
	(5,10);

INSERT INTO EkHizmet_Rezervasyon (
	EkHizmetId, RezervasyonId
) VALUES
	(1,1),
	(1,2),
	(2,3),
	(2,4),
	(3,5),
	(3,6),
	(4,7),
	(4,8),
	(5,9),
	(5,10);

INSERT INTO Olanak_Rezervasyon (
	OlanakId, RezervasyonId
) VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10);

INSERT INTO Oda_Rezervasyon (
	OdaId, RezervasyonId
) VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10);

INSERT INTO Musteri_Rezervasyon (
	MusteriId, RezervasyonId
) VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,4),
	(5,5),
	(6,6),
	(7,7),
	(8,8),
	(9,9),
	(10,10);

/*
SELECT * FROM OtelOlanaklari;
SELECT * FROM Il;
SELECT * FROM Calisan;
SELECT * FROM Musteri;
SELECT * FROM EkHizmet;
SELECT * FROM OdaTipi;
SELECT * FROM Rezervasyon;
SELECT * FROM Ilce;
SELECT * FROM Otel;
SELECT * FROM Oda;
SELECT * FROM Fiyat;
SELECT * FROM Otel_Olanaklar;
SELECT * FROM Otel_Calisan;
SELECT * FROM EkHizmet_Oda;
SELECT * FROM EkHizmet_Rezervasyon;
SELECT * FROM Olanak_Rezervasyon;
SELECT * FROM Oda_Rezervasyon;
SELECT * FROM Musteri_Rezervasyon;
*/

SELECT YEAR(R.BaslangicTarihi) Yil, MONTH(R.BaslangicTarihi) Ay, OT.Ad, F.Deger FROM Rezervasyon R
	LEFT JOIN Oda_Rezervasyon O_R ON O_R.RezervasyonId = R.Id
	INNER JOIN OdaTipi OT ON OT.Id = O_R.OdaId
	LEFT JOIN Fiyat F ON F.OdaTipiId = OT.Id

	-- R. as Yil, Ay, OdaTipi, Tutar, RezervasyonSayisi