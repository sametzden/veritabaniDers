# count, max, min, sum, concat, avg

select avg(Population) from country;

# limit istenilen sayıda kayıt getirmeye yarar
select Name,Population from country 
order by Population desc limit 1,1;

# Like satırlar içerisindeki patterleri aramak için kullnılır
# where sütun adi Like %

select CityName from city 
where CityName Like 'a%' and CountryCode='TUR'; # a ile başlayan iller

select CityName from city 
where CityName Like '%a' and CountryCode='TUR'; # a ile bitenler

select CityName from city 
where CityName Like '%tan%' and CountryCode='TUR'; # içinde as olan iller

select CityName from city 
where CityName Like '_r%' and CountryCode='TUR'; # baştan ikinci karekteri r olanlar


select CityName from city 
where CityName Like 'a_____%' and CountryCode='TUR';

select CityName from city 
where CityName Like 's%t' and CountryCode='TUR'; # s ile başayıp t ile biten

# group by verileri gruplamak için kullanılır
# select sütunlar
# from tablo adı
# where şart
# group by sütunlar
# having şart
# order by sütünlar. max min sum count avg

create database hf12no;
use  hf12no;

CREATE TABLE personel(
perNo INT PRIMARY KEY,
Adi VARCHAR(15) NOT NULL,
soyAdi VARCHAR(15) NOT NULL,
gorev VARCHAR(25),
maas float);

INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('1', 'Ali', 'Kaya', 'Teknisyen', '5000');
INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('2', 'Taner', 'Kaya', 'Teknisyen', '4500');
INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('3', 'Ayşe', 'Kaya', 'Hizmetli', '3000');
INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('4', 'Zeynep', 'Kaya', 'Mühendis', '7000');
INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('5', 'Ramazan', 'Kaya', 'Mühendis', '7500');
INSERT INTO personel (`perNo`, `Adi`, `soyAdi`, `gorev`, `maas`) VALUES ('6', 'Veysel', 'Kaya', 'Hizmetli', '3500');

select count(distinct(gorev)) from personel;

# gorev bazında çalışanların sayısı
select gorev,count(gorev),sum(maas) from personel group by gorev;

# gorevlere göre maaş ortalaması

select gorev,avg(maas) from personel group by gorev;

# her bir görevdeki en yüksek ve en düşük maaş
select gorev, max(maas) as ust, min(maas) as alt
from personel group by gorev;


CREATE TABLE personeller(
perNo INT PRIMARY KEY,
Adi VARCHAR(15) NOT NULL,
soyAdi VARCHAR(15) NOT NULL,
bolum VARCHAR(15),
gorev VARCHAR(25),
maas float);

INSERT INTO personeller  VALUES (1, 'Ali', 'Kaya', 'Üretim', 'Teknisyen', 5000);
INSERT INTO personeller  VALUES (2, 'Taner', 'Kaya', 'Arge','Teknisyen', 4500);
INSERT INTO personeller  VALUES (3, 'Ayşe', 'Kaya', 'Arge','Hizmetli', 3000);
INSERT INTO personeller  VALUES (4, 'Zeynep', 'Kaya', 'Üretim','Mühendis', 7000);
INSERT INTO personeller  VALUES (5, 'Ramazan', 'Kaya', 'Üretim','Mühendis', 7500);
INSERT INTO personeller  VALUES (6, 'Veysel', 'Kaya','Üretim', 'Hizmetli', 3500);

#bölüme göre grupla

select bolum, count(bolum) from personeller
group by bolum;

# her bir bölümdeki personellerin maaşlarına 
#ve görevlerine göre max ve min maas ve toplam personel sayıları

select bolum, gorev,max(maas) as ust,min(maas) as alt,
count(gorev) as sayi
from personeller
group by bolum,gorev order by sayi desc; #desc azalan

CREATE TABLE musteriler(
musteriNo INT PRIMARY KEY,
isim VARCHAR(15) NOT NULL,
borc float,
alacak float);
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('1', 'Ali Kaya', '1900', '700');
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('2', 'Ayşe Dağ', '2400', '2200');
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('3', 'Ahmet Saran', '1500', '300');
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('4', 'Hakan Taşıyan', '1000', '0');
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('5', 'Müge Bulan', '800', '0');
INSERT INTO `musteriler` (`musteriNo`, `isim`, `borc`, `alacak`) VALUES ('6', 'Elif Demir', '0', '120');

# toplam borç ve alacak
select sum(borc) as borc, sum(alacak) as alacak from musteriler;

# kişi bazında alacak ne kadar

select isim, sum(alacak) from musteriler
group by isim;

select isim, sum(alacak-borc) as bakiye
from musteriler group by isim
having bakiye<0;

select CountryCode, count(CityName) as sehir
from city
group by CountryCode
order by sehir desc ;

select CountryCode, count(Language) as sayi
from countrylanguage 
group by CountryCode  
having sayi<4
order by sayi desc;

# her bir ülkedeki en düşük ve en yüksek nüfus toplam nüfus

select CountryCode, max(Population), min(Population) from city
group by CountryCode;

select * from city;


# join 

create table bolumler(
id int primary key,
adi varchar(10)
);

create table ogrenciler(
id int primary key,
adi varchar(10),
soyadi varchar(10),
bkod int);

# where ile birleştirme
select o.adi,o.soyadi,b.adi as bolum_adi from ogrenciler as o, bolumler as b
where o.bkod=b.id;

# inner join
select o.adi,o.soyadi,b.adi as bolum_adi 
from ogrenciler as o
inner join bolumler as b on o.bkod=b.id;


select *
from ogrenciler as o
inner join bolumler as b on o.bkod=b.id;

# left join ilişkide sol taraf önemli

select *
from ogrenciler as o
left join bolumler as b on o.bkod=b.id;

# right join
select *
from ogrenciler as o
right join bolumler as b on o.bkod=b.id;

# full join

select *
from ogrenciler as o
left join bolumler as b on o.bkod=b.id
union
select *
from ogrenciler as o
right join bolumler as b on o.bkod=b.id;

select country.Name,city.CityName,country.Population from 
city inner join country
on country.Code=city.CountryCode;

# ülkelerin başkentlerini göster
select country.Name, city.CityName
from country right join city
on city.CountryCode=country.Code ;

select * from city
where CountryCode is null;