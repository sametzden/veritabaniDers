create database hf11;
use hf11;
drop database hf11;
# insert into tablo adi (c1, c2, ...,cn) values(d1,d2,...dn);

create table person(
id int,
ad varchar(10));
drop table person;
alter table person add primary key(id);

# tabloya veri eklerken insert kullanıyoruz
insert into person(id,ad) values(1,"ali");

insert into person values(2,"isa"); #tüm kolonlara ekleme yapılacaksa kolon isimlerine gerek yok

insert into person (id) values(3);

insert into person(ad) values("hasan");

alter table person modify column id int auto_increment;

insert into person (ad) values("veli");
update person set id= 4 where ad = "hasan";
insert into person(id,ad) values(7,"ali");


alter table person add yas tinyint;

insert into person (ad,yas)
values("ayşe",23),("ahmet",42);

insert into person(yas) values(58);

# update var olan verileri güncelleme
# update tablo adi set c1=val1, c2=val2 where

set sql_safe_updates=0;
update person set yas=12;
update person set yas=28 where ad='ali';

# delete from tablo adi where 

delete from person;

truncate table person;

use sakila;

# select * from tablo
select * from city;
select * from country;
select * from countrylanguage;

select CityName,Population from city;

alter table city rename column Name to CityName;

select * from city where Population>=10000000;

select * from city where Population<500;

select * from country where Name='Turkey';
##################################################################
update country set Population=86000000 where Code='TUR';
update city set Population=86000000 where Code='IST';
select CountryName from country; 

select * from city where Population>300 and Population<1000;
select * from city where Population between 300 and 1000; 

# is null, is not null
select * from country where IndepYear is null or LifeExpectancy is null;

select * from city where CountryCode in ('AZE','TUR','USA');

select * from city where CountryCode='TUR'; 

select * from city where Not CountryCode='TUR';

# DISTINCT
# tekrarlamayan  veriler için kullanılır
select distinct District from city where CountryCode='USA';

# Count
select count(distinct(District)) from city where CountryCode='usa';

select count(distinct(CountryCode)) from city;

select * from city where CountryCode='TUR' and District='Bursa';

# orderby sıralama

select * from city order by Population;
 
select * from city order by Population desc;

select * from city where CountryCode='TUR' order by Population desc;

select * from city where CountryCode='TUR' and cityName='kirikkale';

select * from city order by CountryCode,Population;

# max min 
select * from city where CountryCode='TUR' and 
Population=(select min(population) from city 
where CountryCode='TUR');

select max(CityName) from city;

# alias 
# select sütun name as yeni isim from tablo adı

select cityname as sehiradi from city as sehir;

# concat birden fazla sütunun belli formatta birleşirme yapar

select concat(CityName,"-",Population) as sehirpopulasyon
 from city where CountryCode='TUR';
 
 create table notlar (
 id int primary key,
 ad varchar(10),
 vize int,
 final int)

select ad, (vize*0.4+final*0.6) as gecmenotu from notlar;

select sum(Population) from city 
where CountryCode='AZE';

select * from country where Code='AZE';