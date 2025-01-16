create database cıkmıslar;
use cıkmıslar;

create table gorevler (
gorevNo int primary key,
gorevAdi varchar(40)
);

create table bolumler(
bolumNo int primary key ,
bolumAdi varchar(40)
);

create table personeller (
personelNo int primary key,
personelAdi varchar(30),
personelSoyAdi varchar(30),
personelGorev int,
foreign key (personelGorev)
references gorevler(gorevNo),
personelBolum int,
foreign key (personelBolum)
references bolumler(bolumNo),
personelId int,
personelMaas int
);
drop table personeller;
insert into gorevler values(1, "Memur");
insert into gorevler values(2, "Mühendis");
insert into gorevler values(3, "Doktor");
insert into gorevler values(4, "Muhasebeci");
insert into gorevler values(5, "Pazarlamacı");
insert into gorevler values(6, "İşçi");
insert into gorevler values(7, "Hizmetli");


insert into bolumler values(1,"Muhasebe");
insert into bolumler values(2,"Satış");
insert into bolumler values(3,"Arge");
insert into bolumler values(4,"Üretim");
insert into bolumler values(5,"İnsan Kaynakları");

insert into personeller values(1,"Ahmet", "Kaya", 2,3,533, 12200);
insert into personeller values(2,"Tamer", "Kayalı", 2,3,534, 12000);
insert into personeller values(3,"Hasan", "Güneş", 2,4,532, 13000);
insert into personeller values(4,"Goknur", "Tazar", 1,5,531, 7000);
insert into personeller values(5,"Zeynep", "Yaş", 4,1,550, 9000);
insert into personeller values(6,"Elif", "Gözde", 5,2,544, 7530);
insert into personeller values(7,"İsa", "Nur", 6,4,543, 6330);
insert into personeller values(8,"Ali", "Soy", 6,4,542, 6400);
insert into personeller values(9,"Yusuf", "Taş", 6,4,541, 5200);
insert into personeller values(10,"Halit", "Söz", 7,3,525, 7200);

set sql_safe_updates=0;
# zeynep yaş isimli personelin bölümünü insan Kaynakları numarasını degiştir maaşını 10000 yap
update personeller set personelBolum = (Select bolumNo from bolumler where bolumAdi = "İnsan Kaynakları"), 
personelMaas = 10000 where personelAdi ="Zeynep" and personelSoyAdi = "Yaş"; 

# personel tablosuna dogumTarihi adında bir sutun ekleyiniz ve girilecek degerin 1960 ile 2004 arasında olmasını sağlayınız
alter table personeller add dogumTarihi int;
#alter table personeller Add constraınt chk_dogumTarihi check (dogumTarihi>1960 and dogumTarihi<2004);
alter table personeller add check(dogumTarihi>1960 and dogumTarihi<2004);
# personel tablosuna üretim departmanına iki adet işçi ekleyen kod
insert into personeller values(11, "samet", "özden", (select gorevNo from gorevler where gorevAdi = "İşçi"),
(select bolumNo from bolumler where bolumAdi = "Üretim"), 570 ,8000);

 # üretim departmanında ismi isa olanları silen kod
 delete from personeller where personelAdi = "isa" and personelBolum = (Select bolumNo from bolumler where bolumAdi = "Üretim");
 
 # tüm personellerin adını soyadını görevini departmanını ve maasını goruntükeyen sql sorgusu
 select personelAdi,personelSoyadi,gorevler.gorevAdi as gorev,
 bolumler.bolumAdi as bolum, personelMaas as maas from personeller 
 inner join gorevler on personeller.personelGorev = gorevler.gorevNo
 inner join bolumler on personeller.personelBolum = bolumler.bolumNo;
 

 
 # tüm maasların ortalamasından daha düşük maas alan personellerin adi soyadı bolumu gorevi ve maasını gosteren sql sorgusu
  select personelAdi,personelSoyadi,gorevler.gorevAdi as gorev,
 bolumler.bolumAdi as bolum, personelMaas as maas from personeller 
 inner join gorevler on personeller.personelGorev = gorevler.gorevNo
 inner join bolumler on personeller.personelBolum = bolumler.bolumNo
 where personelMaas <(Select avg(personelMaas) from personeller);
 
 # yusuf taş isimli personel ile gorevi bolumu ve maası aynı personelleri listeleyen sql sorgusu
 Select personelAdi, personelGorev as gorev,
 personelBolum  as bolum from personeller where personelBolum = (Select personelBolum from personeller where personelAdi = "Yusuf" and personelSoyAdi = "Taş") and
 personelGorev = (Select personelGorev from personeller Where personelAdi = "Yusuf" and personelSoyAdi= "Taş");
 # inner joinle gorevin blolumun adı yazdırılabilir
 
# maası genel maas ortalamasının altında olanların maasına  %5 zam yaparak güncelleyen
update personeller set personelMaas = personelMaas + personelMaas*5/100 where personelMaas < (Select avg(personelMaas) from personeller);

