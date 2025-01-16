create database final;
use final;
CREATE TABLE Musteriler (
    MusteriID INT AUTO_INCREMENT PRIMARY KEY,
    MusteriAdi VARCHAR(50) NOT NULL,
    Eposta VARCHAR(100),
    TelefonNo VARCHAR(15),
    Sehir VARCHAR(50)
);

INSERT INTO Musteriler (MusteriAdi, Eposta, TelefonNo, Sehir)
VALUES
('Ahmet Yılmaz', 'ahmet@gmail.com', '05554443322', 'Ankara'),
('Elif Demir', 'elif@gmail.com', '05552221133', 'Istanbul'),
('Mehmet Kaya', 'mehmet@gmail.com', '05551112233', 'Izmir'),
('Ayşe Çelik', 'ayse@gmail.com', '05550009988', 'Bursa');


CREATE TABLE Urunler (
    UrunID INT AUTO_INCREMENT PRIMARY KEY,
    UrunAdi VARCHAR(50) NOT NULL,
    Kategori VARCHAR(50),
    Fiyat DECIMAL(10, 2)
);

INSERT INTO Urunler (UrunAdi, Kategori, Fiyat)
VALUES
('Laptop', 'Elektronik', 7500.00),
('Akıllı Telefon', 'Elektronik', 5000.00),
('Masa', 'Mobilya', 1500.00),
('Sandalye', 'Mobilya', 800.00);


CREATE TABLE Siparisler (
    SiparisID INT AUTO_INCREMENT PRIMARY KEY,
    MusteriID INT,
    SiparisTarihi DATE,
    ToplamTutar DECIMAL(10, 2)
);

INSERT INTO Siparisler (MusteriID, SiparisTarihi, ToplamTutar)
VALUES
(1, '2024-12-20', 7500.00),
(2, '2024-12-21', 5000.00),
(3, '2024-12-22', 2300.00),
(4, '2024-12-23', 1500.00);


CREATE TABLE SiparisDetaylari (
    SiparisDetayID INT AUTO_INCREMENT PRIMARY KEY,
    SiparisID INT,
    UrunID INT,
    Miktar INT
);

INSERT INTO SiparisDetaylari (SiparisID, UrunID, Miktar)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(3, 4, 2),
(4, 3, 1);

-- İlişkiler fiziksel değil ama veriler mantıksal olarak birbirine bağlı

-- Sorular -- 
-- 1 Musteriler tablosundaki tüm kayıtları listeleyen bir sorgu yazınız.
select * from musteriler;
-- 2 Urunler tablosunda fiyatı 3000 TL’den fazla olan ürünleri listeleyen bir sorgu yazınız.
select * from urunler where Fiyat>3000;
-- 3 Siparisler tablosunda toplam tutarı 5000 TL olan siparişlerin sipariş tarihlerini listeleyen bir sorgu yazınız.
select siparisTarihi from siparisler where ToplamTutar = 5000;
-- 4 Musteriler tablosunda şehir bilgisi “Ankara” olan müşterilerin isimlerini listeleyen bir sorgu yazınız.
select musteriAdi from musteriler where sehir = "ankara";
-- 5 Siparisler tablosundan toplam tutarı en yüksek olan siparişin bilgilerini bulun
SELECT * FROM Siparisler
ORDER BY ToplamTutar DESC
LIMIT 1; -- limit kullanarak bu şekilde yapılabilir 
-- alt sorgu ile yapılışı
select * from siparisler where toplamTutar = (Select max(ToplamTutar) from siparisler);
-- 6 Urunler tablosunda “Mobilya” kategorisindeki ürünlerin toplam fiyatını hesaplayınız.
Select Sum(Fiyat) as toplamFiyat from urunler where kategori = "mobilya";
-- 7 SiparisDetaylari tablosundan her bir siparişin toplam miktarını hesaplayan bir sorgu yazınız.
Select SiparisID, Sum(Miktar) as toplamMiktar from siparisdetaylari group by siparisID;
-- 8 Musteriler ve Siparisler tablolarını birleştirerek her müşterinin verdiği siparişlerin toplam tutarını listeleyiniz.
select musteriler.MusteriID ,Musteriler.MusteriAdi, Sum(siparisler.Toplamtutar) as Toplam From musteriler
inner join siparisler
on musteriler.MusteriID = siparisler.MusteriId
GROUP BY Musteriler.MusteriID, Musteriler.MusteriAdi;-- sum kullandıgında group by yapmazsan hata veriyor

-- 9 SiparisDetaylari ve Urunler tablolarını birleştirerek her ürünün toplam satış tutarını hesaplayınız.
select u.urunId, u.urunAdi,Sum(s.miktar) as miktar,Sum(s.miktar* u.fiyat) as toplamSatışTutarı from siparisdetaylari as s 
inner join urunler as u on s.UrunId = u.UrunID 
group by s.UrunId, u.urunAdi;
-- 10 Siparisler tablosunda bir “Trigger” tanımlayın: Yeni bir sipariş eklendiğinde, konsola “Yeni bir sipariş eklendi!” mesajı basılsın.


-- çıkmış sorular--
create database çıkmısFinal;
use çıkmısFinal;

-- Fakülteler tablosu
CREATE TABLE Fakulteler (
    Id INT PRIMARY KEY,
    FakulteAdi VARCHAR(100)
);

INSERT INTO Fakulteler (Id, FakulteAdi) VALUES
(1, 'Mühendislik Fakültesi'),
(2, 'Fen-Edebiyat Fakültesi'),
(3, 'Iktisadi ve Idari Bilimler Fakültesi');

-- Bölümler tablosu
CREATE TABLE Bolumler (
    Id INT PRIMARY KEY,
    BolumAdi VARCHAR(100),
    FakulteId INT,
    FOREIGN KEY (FakulteId) REFERENCES Fakulteler(Id)
);

INSERT INTO Bolumler (Id, BolumAdi, FakulteId) VALUES
(1, 'Bilgisayar Mühendisligi', 1),
(2, 'Fizik', 2),
(3, 'Isletme', 3);

-- Ögrenciler tablosu
CREATE TABLE Ogrenciler (
    Id INT PRIMARY KEY,
    AdSoyad VARCHAR(100),
    BolumId INT,
    DogumT DATE,
    FOREIGN KEY (BolumId) REFERENCES Bolumler(Id)
);

INSERT INTO Ogrenciler (Id, AdSoyad, BolumId, DogumT) VALUES
(1, 'Ali Yilmaz', 1, '2001-05-15'),
(2, 'Ayse Demir', 2, '2002-08-20'),
(3, 'Mehmet Kaya', 3, '2000-03-10');
Insert into ogrenciler(Id, AdSoyad,BolumId) Values (4 , 'samet',1);
Insert into ogrenciler(Id, AdSoyad,BolumId) Values (5 , 'mehmet',1);
Insert into ogrenciler(Id, AdSoyad,BolumId) Values (6 , 'Ahmet',1);
-- Dersler tablosu
CREATE TABLE Dersler (
    Id INT PRIMARY KEY,
    DersAdi VARCHAR(100),
    BolumId INT,
    FOREIGN KEY (BolumId) REFERENCES Bolumler(Id)
);

INSERT INTO Dersler (Id, DersAdi, BolumId) VALUES
(1, 'Programlama', 1),
(2, 'Klasik Mekanik', 2),
(3, 'Muhasebe', 3);

-- DonemDersleri tablosu
CREATE TABLE DonemDersleri (
    Id INT PRIMARY KEY,
    OgrenciId INT,
    DersId INT,
    Notu INT,
    FOREIGN KEY (OgrenciId) REFERENCES Ogrenciler(Id),
    FOREIGN KEY (DersId) REFERENCES Dersler(Id)
);

INSERT INTO DonemDersleri (Id, OgrenciId, DersId, Notu) VALUES
(4,1,2,56),
(5,3,1,52),
(6,2,3,12);

-- Hocalar tablosu
CREATE TABLE Hocalar (
    Id INT PRIMARY KEY,
    AdSoyad VARCHAR(100),
    BolumId INT,
    FOREIGN KEY (BolumId) REFERENCES Bolumler(Id)
);

INSERT INTO Hocalar (Id, AdSoyad, BolumId) VALUES
(1, 'Atilla Ergüzen', 1),
(2, 'Emine Şahin', 2),
(3, 'Hakan Gül', 3);

-- sorular 


alter table ogrenciler add tcno varchar(11);

alter table ogrenciler drop DogumT;

select bolumler.BolumAdi, count(ogrenciler.Id) as ogrenci_sayısı from ogrenciler 
inner join bolumler on ogrenciler.BolumId = bolumler.Id 
where bolumler.BolumAdi = "Bilgisayar Mühendisliği";

SELECT COUNT(DISTINCT donemdersleri.ogrenciid) AS ogrenci_sayisi
FROM donemdersleri
INNER JOIN dersler ON donemdersleri.dersid = dersler.id
WHERE dersler.dersadi = 'Programlama'
  AND donemdersleri.ogrenciid NOT IN (
      SELECT donemdersleri.ogrenciid
      FROM donemdersleri
      INNER JOIN dersler ON donemdersleri.dersid = dersler.id
      WHERE dersler.dersadi = 'Muhasebe'
  );

select Count(o.Id) as sayısı from ogrenciler as o
inner join hocalar as h 
on h.BolumId = o.BolumId 
where h.AdSoyad = "Atilla Ergüzen";

-- her ogrencinin toplam aldıgı ve gectigi dersler
select ogrenciId, dersler.DersAdi from donemdersleri 
inner join dersler on donemdersleri.DersId = Dersler.Id
where notu >= 50;



-- en fazla ögrencisi olan hocanın adı 
Select hocalar.Adsoyad , count(hocalar.Adsoyad) as "ogrenci sayısı"  from hocalar 
inner join ogrenciler 
on ogrenciler.bolumId = hocalar.BolumId
group by hocalar.AdSoyad;


