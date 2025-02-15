/*Tabii, iþte sana bir soru:

Bir öðrenci, birden fazla derse kaydolabilir. Bir dersin final ve vize notlarýnýn ortalamasý 50'nin üzerinde olan öðrencilere, 

Buna göre:
tDersiAlanOgrenciler tablosunda, öðrencilerin vize ve final notlarýnýn ortalamasýný hesaplayýn.
Bu ortalamaya göre baþarý belgesi verilecek öðrencileri seçin.
Sorguyu yaz, ben yardýmcý olurum!*/

select * from tDersiAlanOgrenciler
set language turkish
SELECT
k.Ders_tDerslerID,AVG(k.Vize) as 'Ortalama Vize',AVG(k.Final) 'Ortalama Final',k.Ogrenci_tOgrencilerID
from tDersiAlanOgrenciler as k
GROUP BY Ders_tDerslerID,k.Ogrenci_tOgrencilerID
Having AVG(k.Vize)>50 and AVG(k.Final)>50
