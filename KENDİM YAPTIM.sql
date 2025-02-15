/*Yukar�daki soruda her odada kalan ki�ilerin 
ad,oda ad� ve kalma zaman�n� listeliyiniz*/

select K.Adi,O.Adi,Kn.Zaman from tKonaklamalar as Kn
left join tKisi as K
on K.ID = Kn.Kisi_tKisiID
left join tOda as O
on O.ID = Kn.Oda_tOdaID
/*Her bir odada ka� ki�i kald���n� oda ad� ve kalan ki�i say�s� olacak �ekilde listeleyiniz.*/
select O.Adi as 'Oda Adi',Count(*) as 'Kalan Kisi Sayisi' from tKonaklamalar as Kn
left join tKisi as K
on k.ID = kn.Kisi_tKisiID
left join tOda as O
on O.ID = Kn.Oda_tOdaID
group by O.Adi
/*En son konaklama yap�lan odan�n ad�n� listeleyiniz*/
select top 1 O.Adi as 'Oda Adi' from tKonaklamalar as Kn
left join tOda as O
on kn.ID = O.Oda_tOdaID
order by zaman desc 

/*Her g�n i�in yap�lan konaklama say�lar�n� listeleyiniz.*/

select cast(ko.Zaman as date),count(*) from tKonaklamalar ko
group by cast(ko.Zaman as date)

/*En �ok talebin oldu�u oda ad�n� listeleyin */
select top 1 O.Adi,count(*) from tKonaklamalar as kn
left join tOda as O
on o.ID = kn.Oda_tOdaID 
group by O.Adi
order by count(*) desc 
/*En �ok giderin oldu�u oda ad�n� listeleyiniz.*/
select top 1 O.Adi,SUM(Gd.Miktar) from tGiderler as Gd
left join tOda as O
on O.ID = Gd.Oda_tOdaID
group by O.Adi
order by Sum(Gd.Miktar) desc 
/*Gider t�rlerine g�re giderlerden 100.000tl �st� olan gider t�r� ve gider mikatar�n� listeleyin.*/
select  Gd.Tur_tGiderTurleriID,Sum(Gd.Miktar) from tGiderler as Gd 
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID 
group by Gd.Tur_tGiderTurleriID 
having Sum(Gd.Miktar) > 100.000
/*A12 nolu odaya ait ge�en hafta i�in yap�lan giderleri gider t�r�,toplam gider miktar� olacak �ekilde listeleyin*/
select Gd.Tur_tGiderTurleriID ,SUM(GD.Miktar) from tGiderler as Gd
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID
left join tOda as O
on Gd.Oda_tOdaID = O.ID
left join tKonaklamalar as Kn
on kn.Oda_tOdaID = O.ID
Where O.Adi = A12 AND between g.zaman and  Dateadd(DAY,-7,GETDATE())
group by Gd.Tur_tGiderTurleriID 


/*Otelimizi EN �OK tercih eden VE EN AZ  m��teri ad�n� yaz�n�z.*/
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
/*M��teri ad�n� parametre olarak alan ve o m��terinin kald��� 
odalarda ger�ekle�en gider miktar�n� yaz�n .*/
create procedure proc_GiderMiktar(@MusteriAdi varchar())
as
begin 
	Select K.Adi as 'M�steri Adi',O.Adi as 'Oda Adi', SUM(Gd.Miktar)from tGiderler as Gd
	left join tOda as O
	on Gd.Oda_tOdaID = O.ID 
	left join tKonaklamalar as Kn
	on kn.Oda_tOdaID = O.ID
	left join tKisi as K
	on K.ID = Kn.Kisi_tKisiID
	where @MusteriAdi = K.Adi
	group by K.Adi,O.Adi
end
/*Bu veritaban�nda ihtiya� oldu�unu d���nd���n�z en az 3 index tan�m�n� yap�n�z.
/*Odalar�n adlar� , 
gider t�rleri ve toplam gider miktar�n� i�inde tutacak bir view tan�mlay�p bu view �zerinden odalar�n toplam*/
giderlerini listeleyiniz*/
create view v_OdaTutar
as
Select O.Adi as 'Oda Adi',Gd.Tur_tGiderTurleriID as 'Gider T�rleri',SUM(Gd.Miktar) as 'Toplam Gider Miktari' from tGiderler as Gd
left join tGiderTurleri as Gt
on Gd.Tur_tGiderTurleriID = Gt.ID
left join tOda as O
on O.ID = Gd.Oda_tOdaID
group by O.Adii
select O.Adi, SUM(Gd.Miktar) from v_OdaTutar 
group by O.Adi,Gd.Tur_tGiderTurleriID 

select o.Adi,sum(GidertURU)FROM v_OdaTutar
group by O.Adi


-- Ki�i adi, oda adi, haftan�n g�n�, zaman de�erlerini bir view i�inde tutun.
-- ard�ndan haftan�n g�nlerine g�re toplam m��teri say�s�n� listeleyiniz

create view v_Konaklama
as
select O.Adi,K.Adi, datepart(dayofweek,KN.Zaman) from tKonaklamalar as kn
left join tOda as O
on O.ID = Kn.Oda_tOdaID
left join tKisi as k
on k.ID = Kn.Kisi_tKisiID


Select  datepart(dayofweek,KN.Zaman) , Count(*) from v_Konaklama
group by datepart(dayofweek,KN.Zaman)