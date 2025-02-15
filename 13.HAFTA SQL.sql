/*13.Hafta S�nav Tarz� Sorular*/
/*Yukar�daki soruda her odada kalan ki�ilerin ad,oda ad� ve kalma zaman�n� listeliyiniz*/
select ko.Zaman , K.Adi,O.Adi from tKonaklamalar as Ko
left join tKisi as K
on ko.Kisi_tKisilID = tKisi.ID
left join tOda as O
on O.ID = ko.Oda_tOdaID

/*Her bir odada ka� ki�i kald���n� oda ad� ve kalan ki�i say�s� olacak �ekilde listeleyiniz.*/
select	O.Adi,count(*) from tKonaklamalar as Ko
left join tOda as O
on O.ID = ko.Oda_tOdaID
group by O.Adi

/*En son konaklama yap�lan odan�n ad�n� listeleyiniz*/

select top 1 O.Adi from tKonaklamalar as Ko
left join tOda as O
on O.ID = ko.Oda_tOdaID
order by ko.Zaman desc

/*Her g�n i�in yap�lan konaklama say�lar�n� listeleyiniz.*/

select cast(ko.Zaman as date),count(*) from tKonaklamalar ko
group by cast(ko.Zaman as date)


/*En �ok talebin oldu�u oda ad�n� listeleyin */

select top 1 o.Adi,count(*) from tKonaklamalar as ko
left join tOda as O on ko.Oda_tOdaID = O.ID
group by O.Adi
order by count(*) desc

/*En �ok giderin oldu�u oda ad�n� listeleyiniz. */

select top 1 O.Adi,Sum(G.Miktar) from tGiderler as G
left join tOda as O
on O.ID = G.Oda_tOdaID 
group by O.Adi
order by Sum(G.Miktar) desc

/*Gider t�rlerine g�re giderlerden 100.000tl �st� olan gider t�r� ve gider mikatar�n� listeleyin.*/

select Gt.Adi,Sum(G.Miktar) from tGiderTuru As Gt
left join tGiderler AS G
on G.Tur_TGiderlerRurleriID = Gt.ID
group by Gt.Adi
having sum(G.Miktar) > 100.000

/*A12 nolu odaya ait ge�en hafta i�in yap�lan giderleri gider t�r�,toplam gider miktar� olacak �ekilde listeleyin*/

/*Otelimizi EN �OK tercih eden VE EN AZ  m��teri ad�n� yaz�n�z.*/

select TOP 1 K.Adi from tKonaklamalar as Ko
left join tKisi as K
on ko.Kisi_tKisilID = tKisi.ID
GROUP BY K.Adi
order by count(*) desc
UNION
select TOP 1 K.Adi from tKonaklamalar as Ko
left join tKisi as K
on ko.Kisi_tKisilID = tKisi.ID
GROUP BY K.Adi
order by count(*) ASC

/*M��teri ad�n� parametre olarak alan ve o m��terinin kald��� odalarda ger�ekle�en gider miktar�n� yaz�n .*/




/*Bu veritaban�nda ihtiya� oldu�unu d���nd���n�z en az 3 idex tan�m�n� yap�n�z.
Odalar�n adlar� , 
gider t�rleri ve toplam gider miktar�n� i�inde tutacak bir view tan�mlay�p bu view �zerinden odalar�n toplam
giderlerini listeleyiniz*/
	
create view v_ToplamGider
AS
Begin 
     Select Gt.Adi,O.Adi,Sum(gt.Miktar) from tGiderler as G
	 left join tGiderTurleri as Gt
	 on G.ID = Gt.Tur_tGiderTurleriID
	 left join tOda as O
	 on O.ID = gt.Oda_tOdaID
	 group by Gt.Adi,O.Adi
End
Go
select o.Adi,sum(Gt.Miktar) from v_ToplamGider group by O.Adi

/*Ki�i ad�,oda ad�,konaklaman�n haftan�n g�n� zaman de�erlerini bir view i�inde tutun.Ard�ndan haftan�n g�nlerine g�re Toplam M��teri say�s�n� listeleyin*/

create view v_Konaklama 
AS
Begin
     Select k.Adi,O.Adi,datepart(dayofweek,Ko.Zaman) from tKonaklama as Ko
	 left join tOda as O
	 on O.ID =  Ko.Oda_tOdaID 
	 left join tKisi as K
	 on k.Id = ko.Kisi_TkisiID
End
select  datepart(dayofweek,Ko.Zaman),count(*) from v_Konaklama 
group by datepart(dayofweek,Ko.Zaman)
