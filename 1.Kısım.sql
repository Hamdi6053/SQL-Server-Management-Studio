/*Kullanici adlar� , soyadlar� ve Vize ile Final ortalams�n�n 50 nin alt�nda olanlar�n�n
alt�nda , �st�nde olanlanr�n�n �st�nde olarak yaz�ld��� s�tun ile listeleyin.*/
/*Bilgisayar M�hendisli�i b�l�m�ndeki Matematik dersinin 
ge�me notu en y�ksek 10 ki�iyi listeleyin*/


/*Birden fazla isimli ve birden fazal soyisimli ki�ileri listeleyin.*/

select K.Adi,K.Soyadi from tKullanicilar as k
where (K.Adi like '% %' ) AND (K.Soyadi like '% %')

/*Parametre olarak kan gruplar�n�n adlar�n� aralar�nda virg�l olacak �ekil�de al�p 
o kan gruplar�ndan herhangi birine e�it olan kay�tlar varsa cep telefonu numaralar�n� ekrana listeleyen 
procedure yaz�n.*/

/*Ki�ilerin adlar�n�n ba� harflerine g�re*/

select SUBSTRING(K.Adi,1,1) as 'Ba� Harfi',Avg(LEN(k.Adi)) as 'Ortalama Uzunluk' from tKullanicilar as K
group by  SUBSTRING(K.Adi,1,1)
order by SUBSTRING(K.Adi,1,1)
