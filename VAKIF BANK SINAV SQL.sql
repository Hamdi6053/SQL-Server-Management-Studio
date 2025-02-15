--1.	Bugünün tarihinin sadece yýlýný döndüren sorguyu yazýnýz?
YEAR(GETDATE())
--2.	Aþaðýdaki sorgudaki hatayý düzeltiniz?

SELECT COUNT(*), Country
FROM Customers 
GROUP BY Country 
having COUNT(*) > 5

--3.	Aþaðýdaki sorguda yer alan koþulu baþka nasýl yazýlabilir?
Select * from FRG.Exchange WHERE Amount BETWEEN 10000 and 20000 
select * from FRG.Exchange
where 10000<Amount<20000 
--4.	swf.SwiftJournal tablosunda SwiftId’si 5392228 olan kaydýn SwiftStatus’ünü 9 olarak güncelleyen script’i yazýnýz?
update swf.SwiftJournal
set
SwiftStatus = 9
where SwiftId = 5392228 
--5.	‘Ýstanbul Türkiye’ ifadesinde yer alan boþluk karakterini / (slaþ) ile deðiþtirerek getiren sorguyu yazýnýz?
select replace('Ýstanbul Türkiye',' ','/')

--6.	Bugünün tarihini Date tipinde döndüren sorguyu yazýnýz?
select convert(date,getdate())
--7.	Aþaðýdaki tabloya göre Company_Id’si 2’den büyük olan þirketlerin sayýsýný döndüre sorguyu yazýnýz?
select Sum() from tCompanies
where company_ID > 2

--8.	7. Soruda yer alan tablolardan aþaðýdaki sorguyla dönen kayýtlarý yazýnýz?
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Name = AAA)
--Sonuç döndürmez
--9.	7. Soruda yer alan tablolardan kategorisi 2 olmayan ürünlerin firma isimleri en son kolonda olacak þekilde listesini döndüren sorguyu yazýnýz? 
select C.Company_Name from tProducts as p
left join tCompanies as C
on p.Company_tCompanyID = C.ID
where p.Category != 2


--10.	Aþaðýdaki sorguyu nasýl sadeleþtirirsek sonuç hiç deðiþmez?
--Select ProductName from Products WHERE Company_Id = 4


--11.	7. Soruda yer alan tablolardan aþaðýdaki sorguyla dönen kayýtlarý yazýnýz?

Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Name = ‘DDDD’)
--Sonuc Döndürmez

--12.	7. Soruda yer alan Products tablosunda kaç farklý firmanýn ürünü olduðunu döndüren sorguyu yazýnýz
select COUNT(DISTINCT Company_ýd) from tProducts


--13.	Aþaðýdaki sorguda yer alan hatayý düzeltiniz?
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Id > 1)


--14.	frg.ExchangeTransfer tablosunda yer alan kayýtlarý aþaðýdaki sorguyla güncellerken ne gibi bir risk vardýr?
UPDATE frg.ExchangeTransfer SET FEC = 1 
--Koþul yok ve tüm kayýtlar için 1 güncellemesini yapýyor.

--15.	Cus.Customer tablosunda ismi en uzun olan 3 müþterinin ismini döndüren sorguyu yazýnýz? (CustomerName)
select TOP 3 Company_Name from tCompanies 
ORDER BY len(Company_Name) DESC
--16.	FRG.Exchange tablosunda tutarý (Amount) 10000’den Küçük olan tutarlarýn döviz cinsine göre ortalamasýný azalan olarak döndüren sorguyu yazýnýz?



--17.	Aþaðýdaki sorguda hangi ifadeyi çýkarsak dönen sonuç hiç deðiþmez?
Select TOP 100 * from swf.SwiftJournal ORDER BY 1 ASC
--ASCYÝ ÇIKARSAK DEÐÝÞMEZ.

--18.	Aþaðýdaki Sales tablosunda birim fiyat ortalamasýnýn üzerinde olan kaç farklý ürün olduðunu döndüren sorguyu yazýnýz?
Sales
Id	Product_Id	Unit_Price	Quantity	Amount




--19.	Sales tablosunda birim fiyata (UnitPrice) % 18 Kdv eklenmiþ ve artan þeklinde veri çekilmek isteniyor, gerekli sorguyu yazýnýz?
select (UnitPrice+0.18*UnitPrice) as 'KDV EKLENMÝÞ HAL' from tSales as S 
ORDER BY (UnitPrice+0.18*UnitPrice) ASC
--20.	'1982-09-10' tarihinde doðan birinin kaç gündür yaþadýðýný döndüren sorguyu yazýnýz?

select DATEDIFF(DAY,'1982-09-10',getdate())

