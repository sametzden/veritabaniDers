create database denemeler;
use denemeler;
create table person(
id int,
ad varchar(10));

insert into person(id,ad) values(1,"samet");
insert into person values(2,"ali"); # tüm degerlere atama yapılacaksa bu şekilde kullanılabilir.
alter table person modify column id int primary key ;
alter table person modify column id int auto_increment;
insert into person values("veli");



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


select count(distinct(gorev)) from personel; #distinc kullanmadan 6 kullanılınca 3

# gorev bazında çalışanların sayısı
select gorev,count(gorev) from personel group by gorev;


# gorevlere göre maaş ortalaması
select gorev, avg(maas) from personel group by gorev;

# her bir görevdeki en yüksek ve en düşük maaş
select gorev, min(maas) as "en az",max(maas) as "en fazla" from personel group by gorev;


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
select bolum, count(bolum) from personeller group by bolum;

# her bir bölümdeki personellerin maaşlarına 
#ve görevlerine göre max ve min maas ve toplam personel sayıları

select bolum,gorev, max(maas) as "en fazla" , min(maas) as "en az" , count(bolum) from personeller group by bolum ,gorev;

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
select sum(borc) as borc , sum(alacak) as alacak from musteriler;

# kişi bazında alacak ne kadar
select isim , alacak from musteriler;

select isim, sum(alacak-borc) as bakiye
from musteriler group by isim
having bakiye<0; 
# having group bydan sonra kullanılan where gibi düşünülebilir

INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('1', 'Ali ','Kaya', '1');
INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('2', 'Ayşe','Dağ', '2');
INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('3', 'Ahmet ','Saran', '1');
INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('4', 'Hakan ','Taşıyan', '1');
INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('5', 'Müge ','Bulan', '8');
INSERT INTO `ogrenciler` (`id`, `adi`, `soyadi`, `bkod`) VALUES ('6', 'Elif','Demir', '3');


INSERT INTO `bolumler` (`id`, `adi`) VALUES ('1', 'bilgisayar' );
INSERT INTO `bolumler` (`id`, `adi`) VALUES ('2', 'makine' );
INSERT INTO `bolumler` (`id`, `adi`) VALUES ('3', 'matematik' );
INSERT INTO `bolumler` (`id`, `adi`) VALUES ('4', 'fizik' );


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
