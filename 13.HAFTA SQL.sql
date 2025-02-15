/*13.Hafta Sýnav Tarzý Sorular*/
/*Yukarýdaki soruda her odada kalan kiþilerin ad,oda adý ve kalma zamanýný listeliyiniz*/
select ko.Zaman , K.Adi,O.Adi from tKonaklamalar as Ko
left join tKisi as K
on ko.Kisi_tKisilID = tKisi.ID
left join tOda as O
on O.ID = ko.Oda_tOdaID

/*Her bir odada kaç kiþi kaldýðýný oda adý ve kalan kiþi sayýsý olacak þekilde listeleyiniz.*/
select	O.Adi,count(*) from tKonaklamalar as Ko
left join tOda as O
on O.ID = ko.Oda_tOdaID
group by O.Adi

/*En son konaklama yapýlan odanýn adýný listeleyiniz*/

select top 1 O.Adi from tKonaklamalar as Ko
left join tOda as O
on O.ID = ko.Oda_tOdaID
order by ko.Zaman desc

/*Her gün için yapýlan konaklama sayýlarýný listeleyiniz.*/

select cast(ko.Zaman as date),count(*) from tKonaklamalar ko
group by cast(ko.Zaman as date)


/*En çok talebin olduðu oda adýný listeleyin */

select top 1 o.Adi,count(*) from tKonaklamalar as ko
left join tOda as O on ko.Oda_tOdaID = O.ID
group by O.Adi
order by count(*) desc

/*En çok giderin olduðu oda adýný listeleyiniz. */

select top 1 O.Adi,Sum(G.Miktar) from tGiderler as G
left join tOda as O
on O.ID = G.Oda_tOdaID 
group by O.Adi
order by Sum(G.Miktar) desc

/*Gider türlerine göre giderlerden 100.000tl üstü olan gider türü ve gider mikatarýný listeleyin.*/

select Gt.Adi,Sum(G.Miktar) from tGiderTuru As Gt
left join tGiderler AS G
on G.Tur_TGiderlerRurleriID = Gt.ID
group by Gt.Adi
having sum(G.Miktar) > 100.000

/*A12 nolu odaya ait geçen hafta için yapýlan giderleri gider türü,toplam gider miktarý olacak þekilde listeleyin*/

/*Otelimizi EN ÇOK tercih eden VE EN AZ  müþteri adýný yazýnýz.*/

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

/*Müþteri adýný parametre olarak alan ve o müþterinin kaldýðý odalarda gerçekleþen gider miktarýný yazýn .*/




/*Bu veritabanýnda ihtiyaç olduðunu düþündüðünüz en az 3 idex tanýmýný yapýnýz.
Odalarýn adlarý , 
gider türleri ve toplam gider miktarýný içinde tutacak bir view tanýmlayýp bu view üzerinden odalarýn toplam
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

/*Kiþi adý,oda adý,konaklamanýn haftanýn günü zaman deðerlerini bir view içinde tutun.Ardýndan haftanýn günlerine göre Toplam Müþteri sayýsýný listeleyin*/

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
