create database ornek;
use ornek;
-- 1. Kitaplar Tablosu
CREATE TABLE Kitaplar (
    kitapID INT PRIMARY KEY,
    kitapAdi VARCHAR(100) NOT NULL,
    yazarID INT NOT NULL,
    yayinYili INT NOT NULL,
    fiyat DECIMAL(10, 2) NOT NULL,
    stokAdedi INT NOT NULL
);

-- 2. Yazarlar Tablosu
CREATE TABLE Yazarlar (
    yazarID INT PRIMARY KEY,
    yazarAdi VARCHAR(50) NOT NULL,
    yazarSoyadi VARCHAR(50) NOT NULL,
    ulke VARCHAR(50) NOT NULL
);

-- 3. Siparişler Tablosu
CREATE TABLE Siparisler (
    siparisID INT PRIMARY KEY,
    musteriID INT NOT NULL,
    kitapID INT NOT NULL,
    siparisTarihi DATE NOT NULL,
    adet INT NOT NULL
    
);
drop table siparisler;
-- 4. Müşteriler Tablosu
CREATE TABLE Musteriler (
    musteriID INT PRIMARY KEY,
    musteriAdi VARCHAR(50) NOT NULL,
    musteriSoyadi VARCHAR(50) NOT NULL,
    sehir VARCHAR(50) NOT NULL,
    toplamHarcama DECIMAL(10, 2) NOT NULL
);

-- Verilerin eklenmesi

-- Kitaplar Tablosu
INSERT INTO Kitaplar VALUES 
(1, 'Suç ve Ceza', 1, 1866, 45.00, 10),
(2, 'Savaş ve Barış', 2, 1869, 55.00, 5),
(3, 'Simyacı', 3, 1988, 30.00, 20),
(4, 'Körlük', 4, 1995, 40.00, 8),
(5, 'Hayvan Çiftliği', 5, 1945, 35.00, 15);

-- Yazarlar Tablosu
INSERT INTO Yazarlar VALUES
(1, 'Fyodor', 'Dostoyevski', 'Rusya'),
(2, 'Lev', 'Tolstoy', 'Rusya'),
(3, 'Paulo', 'Coelho', 'Brezilya'),
(4, 'Jose', 'Saramago', 'Portekiz'),
(5, 'George', 'Orwell', 'İngiltere');

-- Müşteriler Tablosu
INSERT INTO Musteriler VALUES
(1, 'Ahmet', 'Yılmaz', 'İstanbul', 120.00),
(2, 'Ayşe', 'Demir', 'Ankara', 55.00),
(3, 'Mehmet', 'Kaya', 'İzmir', 105.00),
(4, 'Elif', 'Şahin', 'Bursa', 55.00);

-- Siparişler Tablosu
INSERT INTO Siparisler VALUES
(1, 1, 1, '2024-01-10', 2),
(2, 2, 3, '2024-01-15', 1),
(3, 3, 5, '2023-12-20', 3),
(4, 4, 2, '2024-01-05', 1),
(5, 5, 4, '2023-11-30', 2);
set sql_safe_updates=0;
# Kitaplar tablosunda stok adedi 5ʼten az olan kitapların fiyatını %10 artıran bir 
update kitaplar set fiyat = fiyat + fiyat*1/10 where stokAdedi < 10;
#   1980 yılından sonra yayınlanan kitaplardan sipariş veren müşterilerin isimlerini ve toplam harcamalarını listeleyen bir SQL sorgusu yazınız.
Select musteriler.musteriAdi, musteriler.toplamHarcama, kitaplar.KitapAdi from siparisler
inner join musteriler on siparisler.MusteriId = musteriler.MusteriId 
inner join kitaplar on kitaplar.KitapId = siparisler.kitapId
where kitaplar.yayinYili <1980;


# En çok sipariş verilen kitabı bulan ve bu kitabın adı, yazar bilgisi ile sipariş edilen toplam adetini listeleyen bir SQL sorgusu yazınız.
Select kitaplar.kitapAdi ,yazarlar.YazarAdi,Yazarlar.YazarSoyAdi, adet from siparisler 
inner join kitaplar on kitaplar.kitapId = siparisler.KitapId
inner join yazarlar on yazarlar.YazarId = Kitaplar.YazarID
where adet = (Select max(adet) from siparisler);

# Müşteriler tablosunda toplam harcaması 100 TLʼnin üzerinde olan müşterilerin yaptığı tüm siparişlerin kitap isimlerini ve sipariş tarihlerini listeleyen bir SQL sorgusu yazınız.
Select kitaplar.KitapAdi, siparisTarihi from siparisler 
inner join kitaplar on kitaplar.KitapId = siparisler.KitapId
inner join musteriler on musteriler.MusteriId = siparisler.MusteriId
where musteriler.toplamHarcama > 100;

 #  Rus yazarların kitaplarını sipariş eden müşterilerin adlarını, soyadlarını ve sipariş tarihlerini listeleyen bir SQL sorgusu yazınız.
select  musteriler.MusteriAdi,musteriler.musteriSoyAdi,siparisler.SiparisTarihi from siparisler
inner join musteriler on musteriler.musteriId = siparisler.MusteriId
inner join kitaplar on siparisler.KitapId = kitaplar.KitapId
inner join yazarlar on yazarlar.yazarId = kitaplar.YazarId
where yazarlar.ulke = "Rusya";


# Sipariş miktarı 2ʼnin üzerinde olan tüm siparişleri ve bu siparişlerin toplam tutarlarını listeleyen bir SQL sorgusu yazınız.
Select siparisId, musteriler.ToplamHarcama from siparisler
inner join musteriler on musteriler.MusteriId = siparisler.MusteriId
where siparisler.adet >= 2;
