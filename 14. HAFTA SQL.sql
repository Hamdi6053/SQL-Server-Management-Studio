 /*CREATE PROCEDURE gizliAdDondur(@KullaniciID int)
as
Begin 
Select concat(left(Adi,1),'***',right(Adi,1),'***',' ', left(Soyadi,1), '***',right(Soyadi,1) )))
from tKullanicilar where ID = @KullaniciID*/

/*Ýstenen çýktý için verilen tablonun sorgusunu yazma*/
select F.Adi , COUNT(*) as 'Ogrenci Sayisi',AVG(D.Vize) as 'Vize Ortalamasý',AVG(D.Final) as 'Final Ortalamasý' FROM  tFakulteler as F
left join tBolumler AS B
on F.ID = B.Fakulte_tFakultelerID
left join tOgrenciler AS o
ON b.ID = O.Bolum_tBolumlerID
LEFT join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
GROUP BY f.Adi

/*Aþaðýdak kodda bazý hatalar yapýlmýþtýr doðrularýn ve hatalarýn neden olduðunu açýlayýn.*/

create procedure gizliAdDondur(@KullaniciID int)
AS
Begin   
    Select concat(k.ID + left(Adi,1) + '***'+ right(Adi,1),left(Soyadi,1) + '***' +right(Soyadi,1))
	from tKullanicilar AS K
	where K.ID = @KullaniciID
End
/*Tek tek hatalarý yazacaksýn .*/

/*Ýki adet kan grubunun adýný parametre olarak alýp bu kan gruplarýndan olan kiþi sayýlarýnýn farkýný geriye dönderen bir procedure yazýn.*/

	 