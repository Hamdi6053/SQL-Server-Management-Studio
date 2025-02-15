 /*CREATE PROCEDURE gizliAdDondur(@KullaniciID int)
as
Begin 
Select concat(left(Adi,1),'***',right(Adi,1),'***',' ', left(Soyadi,1), '***',right(Soyadi,1) )))
from tKullanicilar where ID = @KullaniciID*/

/*�stenen ��kt� i�in verilen tablonun sorgusunu yazma*/
select F.Adi , COUNT(*) as 'Ogrenci Sayisi',AVG(D.Vize) as 'Vize Ortalamas�',AVG(D.Final) as 'Final Ortalamas�' FROM  tFakulteler as F
left join tBolumler AS B
on F.ID = B.Fakulte_tFakultelerID
left join tOgrenciler AS o
ON b.ID = O.Bolum_tBolumlerID
LEFT join tDersiAlanOgrenciler AS D
on D.Ogrenci_tOgrencilerID = o.ID
GROUP BY f.Adi

/*A�a��dak kodda baz� hatalar yap�lm��t�r do�rular�n ve hatalar�n neden oldu�unu a��lay�n.*/

create procedure gizliAdDondur(@KullaniciID int)
AS
Begin   
    Select concat(k.ID + left(Adi,1) + '***'+ right(Adi,1),left(Soyadi,1) + '***' +right(Soyadi,1))
	from tKullanicilar AS K
	where K.ID = @KullaniciID
End
/*Tek tek hatalar� yazacaks�n .*/

/*�ki adet kan grubunun ad�n� parametre olarak al�p bu kan gruplar�ndan olan ki�i say�lar�n�n fark�n� geriye d�nderen bir procedure yaz�n.*/

	 