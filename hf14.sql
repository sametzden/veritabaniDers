# stored procedure

delimiter $$
create procedure musteri()
begin 
 select * from musteri;
end $$
delimiter ;

delimiter $$
create procedure musteri_ara(IN id int)
begin 
 select * from musteri where musteriNo=id;
end $$
delimiter ;

delimiter $$
create procedure musteri_ara_adres(IN id int,IN a varchar(10))
begin 
 select * from musteri where musteriNo=id and Adres=a ;
end $$
delimiter ;

call musteri();

call musteri_ara(1);

call musteri_ara_adres(1,"Sivas");

drop procedure musteri_ara_adres;


create database db3;
use db3;

create table calisanlar(
id int primary key auto_increment,
isim varchar(50),
maas decimal(10,2));


insert into calisanlar(isim,maas)
values("ali",5000.00),("isa",10000.00),("hakan",20000.00);


Delimiter $$
create procedure zam_yap(In i int, in oran decimal(5,2))
begin 
	set sql_safe_updates=0;
    update calisanlar set maas=maas+ (maas*(oran/100))
    where id=i;
end $$

Delimiter ;
drop procedure zam_yap;
call zam_yap(1,100);

#view 

select musteri.adi, count(alis.aracNo) as arac_sayisi
from alis
inner join musteri on musteri.musteriNo=alis.musteriNo
group by alis.musteriNo;

create view musteri_alis as
select musteri.musteriNo,musteri.adi,musteri.soyadi,
alis.aracNo,alis.alisFiyat from alis
inner join musteri on musteri.musteriNo=alis.musteriNo;

select * from musteri_alis;

select adi,count(aracNo) from musteri_alis
group by musteriNo;

alter table calisanlar add bolum_id int;

create table bolumler(
id int primary key auto_increment,
bolum_adi varchar(50));

insert into bolumler(bolum_adi)
values('Yazılım'),('Pazarlama'),('Muhasebe');

create view bolum_maas_ozet as
select bolumler.bolum_adi,count(calisanlar.bolum_id) as sayi,
sum(calisanlar.maas) as top_maas,
avg(calisanlar.maas) as ort_mas 
from bolumler 
left join calisanlar on calisanlar.bolum_id=bolumler.id
group by bolumler.bolum_adi;

select * from bolum_maas_ozet;

#trigger

create database db4;
use db4;

create table calisanlar(
id int primary key auto_increment,
isim varchar(50),
pozisyon varchar(50),
maas decimal(10,2));

create table kayitlar(
id int primary key auto_increment,
olay varchar(50),
olay_tarihi datetime,
cid int);

insert into calisanlar(isim,pozisyon,maas)
values("Ali","Yazılımcı","10000000")

delimiter $$
create trigger after_calisanlar_delete
after delete on calisanlar
for each row
begin 
insert into kayitlar(olay,olay_tarihi,cid)
values("silme",NOW(),old.id);
end$$
delimiter ;

delete from calisanlar where id=1;

delimiter $$
create trigger after_calisanlar_insert
after insert on calisanlar
for each row
begin 
insert into kayitlar(olay,olay_tarihi,cid)
values("ekleme",NOW(),new.id);
end$$
delimiter ;

insert into calisanlar(isim,pozisyon,maas)
values("Ali","Yazılımcı","10000000");

create database db6;
use db6;
create table musteriler(
id int primary key auto_increment,
isim varchar(50),
borc decimal(10,2));

create table islemler(
id int primary key auto_increment,
musteri_id int,
islem varchar(50),
tutar decimal(10,2),
tahsilat decimal(10,2));


insert into musteriler(isim,borc)
values("ali",0),("isa",0);


delimiter ++
create trigger musteri_borc after insert 
on islemler
for each row
begin 
	set sql_safe_updates=0;
   update musteriler set borc=(borc+new.tutar-new.tahsilat)
   where id=new.musteri_id;
end ++
 delimiter ;
 
drop trigger musteri_borc;

insert into islemler(musteri_id,islem,tutar,tahsilat)
values(1,"ram değişimi",1500,500);