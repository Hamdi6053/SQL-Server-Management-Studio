/*Tabii, i�te sana bir soru:

Bir ��renci, birden fazla derse kaydolabilir. Bir dersin final ve vize notlar�n�n ortalamas� 50'nin �zerinde olan ��rencilere, 

Buna g�re:
tDersiAlanOgrenciler tablosunda, ��rencilerin vize ve final notlar�n�n ortalamas�n� hesaplay�n.
Bu ortalamaya g�re ba�ar� belgesi verilecek ��rencileri se�in.
Sorguyu yaz, ben yard�mc� olurum!*/

select * from tDersiAlanOgrenciler
set language turkish
SELECT
k.Ders_tDerslerID,AVG(k.Vize) as 'Ortalama Vize',AVG(k.Final) 'Ortalama Final',k.Ogrenci_tOgrencilerID
from tDersiAlanOgrenciler as k
GROUP BY Ders_tDerslerID,k.Ogrenci_tOgrencilerID
Having AVG(k.Vize)>50 and AVG(k.Final)>50
