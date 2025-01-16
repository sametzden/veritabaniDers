create database hf6no;

create table sehirler(
plaka int auto_increment primary key,
sehirAdi varchar(20)
);

create table ogrenciler(
ogrNo int primary key,
ogrAdi varchar(10),
ogrSoyadi varchar(10),
ogrSehir int,
foreign key (ogrSehir) 
references sehirler(plaka)
);

create table ogrenciler(
ogrNo int primary key,
ogrAdi varchar(10),
ogrSoyadi varchar(10),
ogrSehir int,
constraint ogrenciler_fk_sehiler
foreign key (ogrSehir) 
references sehirler(plaka) on update cascade
on delete SET null
);

# Alter
create table bolumler(
bolumNo int primary key,
bolumAdi varchar(20));

# tablo adi degsimi
alter table bolum rename bolumler;

# tabloya alan ekleme

alter table ogrenciler add bolumId tinyint;

alter table ogrenciler add 
constraint ogrenciler_fk_bolumler
foreign key (bolumId) references 
bolumler(bolumNo);

# alan silme
alter table ogrenciler drop bolumId;
alter table ogrenciler add bolumId int;

alter table ogrenciler add check(ogrNo<10000);

# alan veri tipi yada özellik

alter table ogrenciler modify column
ogrAdi char(5) not null unique;

alter table ogrenciler add dogumTarih int;

alter table ogrenciler modify column
dogumTarih year;

create table sehir(
plaka int auto_increment primary key,
sehirAdi varchar(20)
);

alter table sehir add check(plaka>0 and plaka<81);

alter table sehir modify column
plaka int; 

alter table sehirler modify column
sehirAdi char(50);

alter table ogrenciler rename column
dogumTarih to dTarih;

alter table ogrenciler drop primary key;

alter table ogrenciler add primary key(ogrAdi,ogrSoyadi);

alter table ogrenciler add primary key(ogrNo);

drop table sehirler; 

alter table ogrenciler drop foreign key ogrenciler_fk_sehiler;
