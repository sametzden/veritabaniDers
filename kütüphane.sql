create database kutuphane;
use kutuphane;

create table kategori(
kaId int auto_increment primary key,
KaAd varchar(20)
);

create table yazar(
YNo int primary key,
Yad varchar(20),
YsoyAd varchar(20)
);

create table Adres (
Aid int auto_increment primary key,
Adres text
);

create table Uye (
UyeNo int auto_increment primary key,
UAdi varchar(20),
UsoyAdi varchar(20),
Utel int unique ,
Aid int,
foreign key (Aid)
references Adres (Aid)
);

create table kutuphane (
Kid int primary key unique,
Kisim text,
Aid int,
foreign key (Aid)
references Adres(Aid)
);

create table kitap(
ISBN int unique primary key,
Kbaslık varchar(50),
yTarih datetime
);

create table kitapkategori(
isbn int,
kid int,
primary key (isbn,kid),
foreign key (isbn)
references kitap(ISBN),
foreign key (kid) 
references kategori(kaId)
);

create table kitapyazar(
isbn int,
yazarNo int,
primary key (isbn,yazarNo),
foreign key (isbn) 
references kitap(ISBN),
foreign key (yazarNo)
references yazar(YNo)
);

create table kutuphanekitap(
isbn int,
kutuphaneId int,
primary key (isbn,kutuphaneId),
miktar int,
foreign key (isbn)
references kitap(ISBN),
foreign key(kutuphaneId)
references kutuphane(Kid)
);

create table emanet(
Eid int primary key ,
Etarih datetime,
GDtarih datetime,
uyeNo int,
kutuphaneId int,
foreign key (uyeNo)
references Uye(UyeNo),
foreign key (kutuphaneId)
references kutuphane (Kid)
);

create table kitapEmanet (
isbn int,
Eid int,
primary key (isbn, Eid),
foreign key (isbn)
references kitap(ISBN),
foreign key (Eid)
references emanet(Eid)
);





