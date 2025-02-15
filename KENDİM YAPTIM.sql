/*Yukarýdaki soruda her odada kalan kiþilerin 
ad,oda adý ve kalma zamanýný listeliyiniz*/

select K.Adi,O.Adi,Kn.Zaman from tKonaklamalar as Kn
left join tKisi as K
on K.ID = Kn.Kisi_tKisiID
left join tOda as O
on O.ID = Kn.Oda_tOdaID
/*Her bir odada kaç kiþi kaldýðýný oda adý ve kalan kiþi sayýsý olacak þekilde listeleyiniz.*/
select O.Adi as 'Oda Adi',Count(*) as 'Kalan Kisi Sayisi' from tKonaklamalar as Kn
left join tKisi as K
on k.ID = kn.Kisi_tKisiID
left join tOda as O
on O.ID = Kn.Oda_tOdaID
group by O.Adi
/*En son konaklama yapýlan odanýn adýný listeleyiniz*/
select top 1 O.Adi as 'Oda Adi' from tKonaklamalar as Kn
left join tOda as O
on kn.ID = O.Oda_tOdaID
order by zaman desc 

/*Her gün için yapýlan konaklama sayýlarýný listeleyiniz.*/

select cast(ko.Zaman as date),count(*) from tKonaklamalar ko
group by cast(ko.Zaman as date)

/*En çok talebin olduðu oda adýný listeleyin */
select top 1 O.Adi,count(*) from tKonaklamalar as kn
left join tOda as O
on o.ID = kn.Oda_tOdaID 
group by O.Adi
order by count(*) desc 
/*En çok giderin olduðu oda adýný listeleyiniz.*/
select top 1 O.Adi,SUM(Gd.Miktar) from tGiderler as Gd
left join tOda as O
on O.ID = Gd.Oda_tOdaID
group by O.Adi
order by Sum(Gd.Miktar) desc 
/*Gider türlerine göre giderlerden 100.000tl üstü olan gider türü ve gider mikatarýný listeleyin.*/
select  Gd.Tur_tGiderTurleriID,Sum(Gd.Miktar) from tGiderler as Gd 
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID 
group by Gd.Tur_tGiderTurleriID 
having Sum(Gd.Miktar) > 100.000
/*A12 nolu odaya ait geçen hafta için yapýlan giderleri gider türü,toplam gider miktarý olacak þekilde listeleyin*/
select Gd.Tur_tGiderTurleriID ,SUM(GD.Miktar) from tGiderler as Gd
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID
left join tOda as O
on Gd.Oda_tOdaID = O.ID
left join tKonaklamalar as Kn
on kn.Oda_tOdaID = O.ID
Where O.Adi = A12 AND between g.zaman and  Dateadd(DAY,-7,GETDATE())
group by Gd.Tur_tGiderTurleriID 


/*Otelimizi EN ÇOK tercih eden VE EN AZ  müþteri adýný yazýnýz.*/
select top 1 K.Adi , count(*) from tKonaklamar as Kn
left join tKisi as K
on k.Id = kn.Kisi_tKisiID
group by k.Adi
order by count(*) desc
union
select top 1 K.Adi , count(*) from tKonaklamar as Kn
left join tKisi as K
on k.Id = kn.Kisi_tKisiID
group by k.Adi
order by count(*) asc
/*Müþteri adýný parametre olarak alan ve o müþterinin kaldýðý 
odalarda gerçekleþen gider miktarýný yazýn .*/
create procedure proc_GiderMiktar(@MusteriAdi varchar())
as
begin 
	Select K.Adi as 'Müsteri Adi',O.Adi as 'Oda Adi', SUM(Gd.Miktar)from tGiderler as Gd
	left join tOda as O
	on Gd.Oda_tOdaID = O.ID 
	left join tKonaklamalar as Kn
	on kn.Oda_tOdaID = O.ID
	left join tKisi as K
	on K.ID = Kn.Kisi_tKisiID
	where @MusteriAdi = K.Adi
	group by K.Adi,O.Adi
end
/*Bu veritabanýnda ihtiyaç olduðunu düþündüðünüz en az 3 index tanýmýný yapýnýz.
/*Odalarýn adlarý , 
gider türleri ve toplam gider miktarýný içinde tutacak bir view tanýmlayýp bu view üzerinden odalarýn toplam*/
giderlerini listeleyiniz*/
create view v_OdaTutar
as
Select O.Adi as 'Oda Adi',Gd.Tur_tGiderTurleriID as 'Gider Türleri',SUM(Gd.Miktar) as 'Toplam Gider Miktari' from tGiderler as Gd
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID
left join tOda as O
on O.ID = Gd.Oda_tOdaID
group by O.Adii
select O.Adi, SUM(Gd.Miktar) from v_OdaTutar 
group by O.Adi,Gd.Tur_tGiderTurleriID 

select o.Adi,sum(GidertURU)FROM v_OdaTutar
group by O.Adi


-- Kiþi adi, oda adi, haftanýn günü, zaman deðerlerini bir view içinde tutun.
-- ardýndan haftanýn günlerine göre toplam müþteri sayýsýný listeleyiniz

create view v_Konaklama
as
select O.Adi,K.Adi, datepart(dayofweek,KN.Zaman) from tKonaklamalar as kn
left join tOda as O
on O.ID = Kn.Oda_tOdaID
left join tKisi as k
on k.ID = Kn.Kisi_tKisiID


Select  datepart(dayofweek,KN.Zaman) , Count(*) from v_Konaklama
group by datepart(dayofweek,KN.Zaman)