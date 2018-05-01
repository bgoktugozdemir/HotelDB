USE OTEL

INSERT INTO OtelOlanaklari VALUES
	('Mescid'),
	('Spor Salonu'),
	('Golf'),
	('Disko'),
	('SPA'),
	('Masaj'),
	('Bar'),
	('Havuz'),
	('Hamam'),
	('Yemek Salonu');

INSERT INTO Il VALUES
	('Adana'),
	('Adıyaman'),
	('Afyonkarahisar'),
	('Ağrı'),
	('Amasya'),
	('Ankara'),
	('Antalya'),
	('Artvin'),
	('Aydın'),
	('Balıkesir'),
	('Bilecik'),
	('Bingöl'),
	('Bitlis'),
	('Bolu'),
	('Burdur'),
	('Bursa'),
	('Çanakkale'),
	('Çankırı'),
	('Çorum'),
	('Denizli'),
	('Diyarbakır'),
	('Edirne'),
	('Elazığ'),
	('Erzincan'),
	('Erzurum'),
	('Eskişehir'),
	('Gaziantep'),
	('Giresun'),
	('Gümüşhane'),
	('Hakkâri'),
	('Hatay'),
	('Isparta'),
	('İçel (Mersin)'),
	('İstanbul'),
	('İzmir'),
	('Kars'),
	('Kastamonu'),
	('Kayseri'),
	('Kırklareli'),
	('Kırşehir'),
	('Kocaeli'),
	('Konya'),
	('Kütahya'),
	('Malatya'),
	('Manisa'),
	('Kahramanmaraş'),
	('Mardin'),
	('Muğla'),
	('Muş'),
	('Nevşehir'),
	('Niğde'),
	('Ordu'),
	('Rize'),
	('Sakarya'),
	('Samsun'),
	('Siirt'),
	('Sinop'),
	('Sivas'),
	('Tekirdağ'),
	('Tokat'),
	('Trabzon'),
	('Tunceli'),
	('Şanlıurfa'),
	('Uşak'),
	('Van'),
	('Yozgat'),
	('Zonguldak'),
	('Aksaray'),
	('Bayburt'),
	('Karaman'),
	('Kırıkkale'),
	('Batman'),
	('Şırnak'),
	('Bartın'),
	('Ardahan'),
	('Iğdır'),
	('Yalova'),
	('Karabük'),
	('Kilis'),
	('Osmaniye'),
	('Düzce');

INSERT INTO Calisan(
	KimlikNo, Cinsiyet, TelefonNumarasi, Ad, Soyad, DogumTarihi, Email
) VALUES
	('12345678901', 'E', '5357654321', 'Türkalp', 'Kayrancı', '1997-05-17', 'bkayranci@gmail.com'),
	('12345678902', 'K', '5357654322', 'Ayşe'	, 'Düzgiden', '1988-04-21', 'duzgidenayse@gmail.com'),
	('12345678903', 'D', '5357654323', 'Deniz'	, 'Görmüş', '1992-09-28', 'gormusdeniz@gmail.com'),
	('12345678904', 'E', '5357654324', 'Göktuğ'	, 'Özdemir', '1997-07-16', 'bgoktugozdemir@gmail.com'),
	('12345678905', 'K', '5357654325', 'Edanur'	, 'Özdemir', '1997-01-22', 'ozdemireda@gmail.com'),
	('12345678906', 'E', '5357654326', 'Ümit'	, 'Küçük', '1997-01-19', 'umitkucuk@gmail.com'),
	('12345678907', 'E', '5357654327', 'Hakan'	, 'Kösdağ', '1997-09-20', 'hakankosdag@gmail.com'),
	('12345678908', 'K', '5357654328', 'Hayriye', 'Kasapçı', '1991-09-17', 'kasapciii@gmail.com'),
	('12345678909', 'D', '5357654329', 'Fatih'	, 'Teksoy', '1991-05-17', 'fatih@gmail.com'),
	('12345678910', 'E', '5357654310', 'Fatih'	, 'Termin', '1983-05-17', 'fatih.ter@gmail.com'),
	('12345578907', 'E', '5357654327', 'Halis'	, 'Kösdağ', '1977-09-20', 'koshalis@gmail.com'),
	('12345478908', 'K', '5357654328', 'Gamze', 'Teksoy', '1981-09-17', 'gamzetek@gmail.com'),
	('12345378907', 'E', '5357654327', 'Kemal'	, 'Odun', '1997-09-20', 'odunkemal@gmail.com'),
	('12345278908', 'E', '5357654328', 'Enes', 'Usak', '1981-10-17', 'usak@gmail.com'),
	('12345178907', 'E', '5357654327', 'Enes'	, 'Usak', '1997-09-20', 'enesusak@gmail.com'),
	('12345078908', 'K', '5357654328', 'Emel', 'Elverdi', '1992-09-17', 'eldiven@gmail.com'),
	('12345978907', 'E', '5357654327', 'Tarık'	, 'Tandoğdu', '1957-09-20', 'tandogdu@gmail.com'),
	('12345878908', 'K', '5357654328', 'Rüya', 'Ayık', '1986-09-17', 'ayikruya@gmail.com'),
	('12345778907', 'E', '5357654327', 'Hakan'	, 'Ayık', '1997-09-20', 'hakanayik@gmail.com'),
	('12346678908', 'K', '5357654328', 'Hayriye', 'Kasapçı', '1996-09-17', 'kasapci.hayriye@gmail.com');

INSERT INTO Musteri (
	KimlikNo, Cinsiyet, TelefonNumarasi, Ad, Soyad, DogumTarihi, Email
) VALUES
	('12345678901', 'E', '5347654321', 'Türkalp', 'Kayrancý'	, '1997-05-17', 'hdksadnalsdnas@gmail.com'),
	('12345678904', 'E', '5347654324', 'Göktuð'	, 'Özdemir'		, '1997-07-16', 'kkkk@gmail.com'),
	('12345678906', 'E', '5347654326', 'Ümit'	, 'Küçük'		, '1997-01-19', 'asdsad@gmail.com'),
	('12345678908', 'K', '5347654328', 'Hayriye', 'Kasapçý'		, '1991-09-17', '1234@gmail.com');

INSERT INTO Musteri(
	KimlikNo, Cinsiyet, TelefonNumarasi, Ad, Soyad, DogumTarihi
) VALUES
	('12345678902', 'K', '5347654322', 'Ayþe'	, 'Düzgiden'	, '1988-04-21'),
	('12345678903', 'D', '5347654323', 'Deniz'	, 'Görmüþ'		, '1992-09-28'),
	('12345678905', 'K', '5347654325', 'Edanur'	, 'Özdemir'		, '1997-01-22'),
	('12345678907', 'E', '5347654327', 'Hakan'	, 'Kösdað'		, '1997-09-20'),
	('12345678909', 'D', '5347654329', 'Fatih'	, 'Teksoy'		, '1991-05-17'),
	('12345678910', 'E', '5347654310', 'Fatih'	, 'Termin'		, '1983-05-17');

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
	('Tek Kişilik'),
	('Çift Kişilik'),
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
	Ad, Telefon, Adres, Email, OtelPuani, OtelYildizi, IlId, IlceId 
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
	-- 12 aylik otel olanaklari
	(0, '2018-01-01', '2018-12-01', 1, NULL, NULL),
	(30, '2018-01-01', '2018-12-01', 2, NULL, NULL),
	(50, '2018-01-01', '2018-12-01', 3, NULL, NULL),
	(40, '2018-01-01', '2018-12-01', 4, NULL, NULL),
	(35, '2018-01-01', '2018-12-01', 5, NULL, NULL),
	(0, '2018-01-01', '2018-12-01', 6, NULL, NULL),
	(0, '2018-01-01', '2018-12-01', 7, NULL, NULL),
	(0, '2018-01-01', '2018-12-01', 8, NULL, NULL),
	(0, '2018-01-01', '2018-12-01', 9, NULL, NULL),
	(0, '2018-01-01', '2018-12-01', 10, NULL, NULL),

	-- ilk 6 aylik oda tipi fiyatlari
	(300, '2018-01-01', '2018-06-01', NULL, 5, NULL),
	(250, '2018-01-01', '2018-06-01', NULL, 4, NULL),
	(230, '2018-01-01', '2018-06-01', NULL, 3, NULL),
	(200, '2018-01-01', '2018-06-01', NULL, 2, NULL),
	(150, '2018-01-01', '2018-06-01', NULL, 1, NULL),
	-- son 6 aylik oda tipi fiyatlari
	(310, '2018-06-01', '2018-12-01', NULL, 5, NULL),
	(280, '2018-06-01', '2018-12-01', NULL, 4, NULL),
	(235, '2018-06-01', '2018-12-01', NULL, 3, NULL),
	(205, '2018-06-01', '2018-12-01', NULL, 2, NULL),
	(190, '2018-06-01', '2018-12-01', NULL, 1, NULL),

	-- ilk 6 aylik ek hizmet fiyatlari
	(200, '2018-01-01', '2018-06-01', NULL, NULL, 5),
	(80, '2018-01-01', '2018-06-01', NULL, NULL, 4),
	(60, '2018-01-01', '2018-06-01', NULL, NULL, 3),
	(50, '2018-01-01', '2018-06-01', NULL, NULL, 2),
	(25, '2018-01-01', '2018-06-01', NULL, NULL, 1),
	-- son 6 aylik ek hizmet fiyatlari
	(220, '2018-06-01', '2018-12-01', NULL, NULL, 5),
	(100, '2018-06-01', '2018-12-01', NULL, NULL, 4),
	(80, '2018-06-01', '2018-12-01', NULL, NULL, 3),
	(60, '2018-06-01', '2018-12-01', NULL, NULL, 2),
	(30, '2018-06-01', '2018-12-01', NULL, NULL, 1);


INSERT INTO Otel_OtelOlanaklari (
	OtelId, OtelOlanaklariId
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

INSERT INTO Oda_EkHizmet(
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

INSERT INTO Rezervasyon_EkHizmet(
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

INSERT INTO Rezervasyon_OtelOlanaklari(
	OtelOlanaklariId, RezervasyonId
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

INSERT INTO Rezervasyon_Oda(
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

INSERT INTO Rezervasyon_Musteri(
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
