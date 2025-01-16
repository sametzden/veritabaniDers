# alt  select alt sorgular

select * from ogrenci
where adi="ali" and soyadi="kaya";

select * from ogrenci 
where bolum=1;

 
select adi,soyadi from ogrenci
where bolum=(select bolum from ogrenci where adi="ali" 
and soyadi="kaya");

# insert alt sorgu
create table bilgogrenci(
id int primary key auto_increment,
ad varchar(10),
soyad varchar(10)
);

insert into bilgogrenci (ad,soyad)
select adi,soyadi from ogrenci
where 
bolum=(select bid from bolum where badi='Bilgisayar');

insert into bilgogrenci (ad,soyad)
select adi,soyadi from ogrenci
inner join bolum on bolum.bid=ogrenci.bolum
where bolum.badi='Bilgisayar';

# update alt sorgu
set sql_safe_updates=0;

# fizik bölümündeki herksi bilgisayara geçirin

update ogrenci set bolum=(select bid from 
bolum where badi="Bilgisayar")
where bolum=(select bid from bolum where 
badi='Fizik');

# delete 

delete from ogrenci 
where bolum=(select bid from bolum where badi="bilgisayar");

select adi,soyadi from 
ogrenci where bolum not in (select bid from bolum
where badi='bilgisayar' or badi="fizik");

select id, adi, (select badi from bolum 
where bolum.bid=ogrenci.bolum) as bolumadi from ogrenci;

# türkiyede ortalama nüfusun üzerinde olan şehilerin isimleri

select city.Name from city
where Population>(select avg(Population) from city 
where CountryCode='TUR')
and CountryCode='TUR'; 

create database hf13io;
use hf13io;

SELECT * from  city
where CountryCode='TUR' and
Population>(SELECT avg(Population) 
from city where CountryCode='TUR');

create database hf13;
use hf13;
CREATE TABLE Musteri(
musteriNo INT PRIMARY KEY,
Adi VARCHAR(15) NOT NULL,
soyAdi VARCHAR(15) NOT NULL,
Adres VARCHAR(50),
Telefon VARCHAR(15));

CREATE TABLE Arac(
aracNo INT PRIMARY KEY,
Marka VARCHAR(50) NOT NULL,
model int NOT NULL,
Plaka VARCHAR(15));

CREATE TABLE Alis(
alisNo INT PRIMARY KEY,
musteriNo int NOT NULL,
aracNo int NOT NULL,
alisTarih VARCHAR(15),
alisFiyat float);

CREATE TABLE Satis(
satisNo INT PRIMARY KEY,
musteriNo int NOT NULL,
aracNo int NOT NULL,
satisTarih VARCHAR(15),
satisFiyat float);

INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('1', 'Ali', 'Kaya', 'Sivas', '55522110');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('2', 'Ahmet', 'Dereli', 'Ankara', '5552221111');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('3', 'Eif ', 'Dağlı', 'İstanbul', '5552221112');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('4', 'Murat', 'Ayın', 'Sivas', '555222113');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('5', 'Beyza', 'Kurt', 'Kırıkkale', '5552221114');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('6', 'İsa', 'Yanar', 'Ankara', '5552221115');
INSERT INTO `musteri` (`musteriNo`, `Adi`, `soyAdi`, `Adres`, `Telefon`) VALUES ('7', 'Hasan', 'Karakaya', 'İstanbul', '5552221118');

INSERT INTO `arac` (`aracNo`, `Marka`, `model`, `Plaka`) VALUES ('1', 'Ford Focus', '2005', '58EN414');
INSERT INTO `arac` (`aracNo`, `Marka`, `model`, `Plaka`) VALUES ('2', 'Renault Megane', '2000', '58SC511');
INSERT INTO `arac` (`aracNo`, `Marka`, `model`, `Plaka`) VALUES ('3', 'Fiat Egea', '2018', '58SC444');
INSERT INTO `arac` (`aracNo`, `Marka`, `model`, `Plaka`) VALUES ('4', 'Opel Astra', '2011', '58SC555');
INSERT INTO `arac` (`aracNo`, `Marka`, `model`, `Plaka`) VALUES ('5', 'Audi A4', '2019', '58SC554');

INSERT INTO `satis` (`satisNo`, `musteriNo`, `aracNo`, `satisTarih`,`satisFiyat`) VALUES ('1', '1', '1', '04.05.2020',17000);
INSERT INTO `satis` (`satisNo`, `musteriNo`, `aracNo`, `satisTarih`,`satisFiyat`) VALUES ('2', '4', '5', '01.06.2020',11500);
INSERT INTO `satis` (`satisNo`, `musteriNo`, `aracNo`, `satisTarih`,`satisFiyat`) VALUES ('3', '7', '4', '15.06.2020',27000);
INSERT INTO `satis` (`satisNo`, `musteriNo`, `aracNo`, `satisTarih`,`satisFiyat`) VALUES ('4', '2', '1', '02.07.2020',17500);


INSERT INTO `alis` (`alisNo`, `musteriNo`, `aracNo`, `alisTarih`, `alisFiyat`) VALUES ('1', '3', '1', '04.04.2020', '15000');
INSERT INTO `alis` (`alisNo`, `musteriNo`, `aracNo`, `alisTarih`, `alisFiyat`) VALUES ('2', '6', '1', '12.04.2021', '15500');
INSERT INTO `alis` (`alisNo`, `musteriNo`, `aracNo`, `alisTarih`, `alisFiyat`) VALUES ('3', '2', '5', '15.06.2021', '9500');
INSERT INTO `alis` (`alisNo`, `musteriNo`, `aracNo`, `alisTarih`, `alisFiyat`) VALUES ('4', '1', '2', '18.07.2021', '14000');
INSERT INTO `alis` (`alisNo`, `musteriNo`, `aracNo`, `alisTarih`, `alisFiyat`) VALUES ('5', '5', '2', '19.09.2021', '26000');


# en yüksek fiyata satılan araç bilgilerini getiren kodu yazınız
select * from arac
where aracNo=(select aracNo from satis
where satisFiyat=(select max(satisFiyat) from satis));

select * from arac
where aracNo=(select aracNo from satis 
order by satisFiyat desc limit 1);

# en düşük fiyat 
select * from arac
where aracNo=(select aracNo from satis 
order by satisFiyat limit 1);

# en düşük fiyata satılan araç kaça satılmış
select arac.marka,satis.satisFiyat
from satis
inner join arac on arac.aracNo=satis.aracNo
order by satisFiyat Limit 1;

# en düşük fiyata satılan araç kime satılmış markası, satiş fiyatı

select *
from satis
inner join musteri on musteri.musteriNo=satis.musteriNo
inner join arac on arac.aracNo=satis.aracNo
where satis.satisFiyat=(select min(satisFiyat) from satis);

# satış yada alış yapılmayan müşteri
select * from musteri 
where musteriNo not in (select musteriNo from satis)
and musteriNo not in (select musteriNo from alis);

# satilan araçların bilgileri
select * from satis
left join arac on arac.aracNo=satis.aracNo;

# her bir müşterinden alınan araç sayısını listelyen kod
select musteri.Adi,count(alis.musteriNo) from alis
inner join musteri on musteri.musteriNo=alis.musteriNo
group by alis.musteriNo;