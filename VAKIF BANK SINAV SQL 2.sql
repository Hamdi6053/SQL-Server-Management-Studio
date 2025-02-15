--1. Bugünün tarihine ay ekledikten sonraki tarihi döndüren sorguyu yazýnýz? 
select dateadd(MONTH,1,GETDATE()) as 'Eklenmiþ Hal'
--2. Products tablosunda birim fiyatý (UnitPrice) 100 TL’den büyük olan ürünlere %10 zam yapýlacak 100 TL olan ve 
--daha düþük olan ürünlere %20 zam yapýlacaktýr. Her bir ürünü ve bu ürünlerin zamlý birim fiyatýný döndüren 
--sorguyu yazýnýz?  
SELECT 
product_name,
     CASE
	     when unitprice>100 then (unitprice+0.1*unitprice),
		 when unitprice<= 100 then (unitprice+0.2*unitprice),
		 else 
	 End as 'zamlý birim fiyat'
from tProducts

--3. Aþaðýdaki sorguda yer alan hatalarý düzeltiniz? 
Select IIF(Age < 35, 'Genç', 'Orta Yaþlý') as Genç Mi * from Employee ORDER BY Id DES 
--Düzeltilmiþ
Select IIF(Age<35, 'Genç', 'Orta Yaþlý') as 'Genç Mi' , * from Employee 
Order by ID DESC

--4. Status’ü 1 olan veya isProcessed’i 0 olan kayýtlarýn MessageType’ýný ‘MT199’ ve MtId’sini 9876543 
--olarak güncelleyen script’i yazýnýz? 
UPDATE tTabloAdi
Set
MessageType = 'MT199' , MtID = 9876543
where Statüs = 1 OR isProcessed = 0

--5. Employee tablosunda Cinsiyeti K olan personellerin isminin (EmployeeName) sonuna ‘ Haným,’ ve E olan 
--personellerin isminin sonuna ‘ Bey,’  getiren sorguyu yazýnýz? 
SELECT 
    Personel_Name + 
    CASE 
        WHEN Cinsiyet = 'K' THEN ' Haným'
        WHEN Cinsiyet = 'E' THEN ' Bey'
        ELSE ' Deðerlendirme dýþý'
    END AS Updated_Name
FROM tEmployee;


--6. Hangi ürün hangi kategoride döndüren sorguyu yazýnýz? 

select Product_Name,Category from tProdects

--7. Altýnda ürün bulunmayan kategorileri döndüren sorguyu yazýnýz? 
select * from tProducts


--8. Hiç sipariþ vermemiþ olan müþterileri döndüren sorguyu yazýnýz? 
--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID 

 select CustomerName from tCustomers as C
 left join tOrders  As O
 ON C.ID = O.Customer_tCustomerID
 where O.OrderID is null

-- 9. Sorudaki tablolarý baz alarak þehri Ýstanbul olan müþterilerden elde edilen gelirlerin toplamýný döndüren 
--sorguyu yazýnýz? (Adet bazýnda)

select C.CustomerName,Sum(O.Amount) from tCustomers as C
left join tOrders as O
on C.ID = O.Customer_tCustomerID
where C.City = 'Ýstanbul'
group by C.CustomerName 

select Sum(O.Amount) from tCustomers as C
left join tOrders as O
on C.ID = O.Customer_tCustomerID
where C.City = 'Ýstanbul'


-- 10.her bir müþterinin ürün bazýnda kaç tane sipariþ 
--verdiðini döndüren sorguyu yazýnýz? 

--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID 
select  C.CustomerName,ProductID,count(O.OrderID) from tOrders as O
left join tCustomers as C
on o.Customer_tCustomerID = C.ID 
group by C.CustomerName,ProductID

--11. 9. Sorudaki tablolarý baz alarak 2022 yýlýnda en çok satýþ yapan personel id’sini döndüren sorguyu yazýnýz? 
--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID


--12. En çok satýþ yapan üç personele yaptýklarý satýþ tutarý üzerinden % 5 pirim verilecektir, hangi personellere ne 
--kadar pirim verileceðini döndüren sorguyu yazýnýz? 




--13. Aþaðýdaki tabloya göre Company_Id’si 50’den büyük ve 300’den küçük olan þirketlerin isminde ‘a’ geçen 
--þirketlerin adreslerini döndüren sorguyu yazýnýz? 
select Company_Address  from tCompanies as C
where 50 < C.Company_ýd < 300 and C.Company_Name like '%a%'

--14. 13. Soruda yer alan tablolardan aþaðýdaki sorguyla dönen kayýtlarý yazýnýz? 
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where 
Company_Name like ‘Bostancý’) 

-- Sonuç döndürmez 

--15. 13. Soruda yer alan tablolardan kategorisi 2 olan ürünlerin firma isimlerini döndüren sorguyu yazýnýz?  

select Company_Name from tCompanies as C
left join tProducts as P
on C.ID = P.Company_tCompanyID
where P.Category = 2 


--16. 13. Soruda yer alan tablolardan aþaðýdaki sorguyla dönen kayýtlarý yazýnýz? 
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where 
Company_Address like ‘%a%’)

--Bigisayar,Buzdolabý,Sehpa,Battaniye 

--17. 13. Soruda yer alan Products tablosunda kaç farklý firmanýn ürünü olduðunu döndüren sorguyu yazýnýz?

select COUNT(DISTINCT COMPANY_ID) from tProducts


--18. Aþaðýdaki iki sorgu sonucu arasýnda bir fark var mýdýr? 
Select * from FRG.Exchange where Reference = '70VK24000' 
Select * from FRG.Exchange where Reference like '70VK24000' 

--Evet var biri direkt o hücrenin için '70VK24000' bundan geçen yani like 
--Diðeri ise direkt buna eþit olan reference kolonunu arar yani in komutu
--Farklý iki sorgu çýktýsý farklý olacaktýr.


--19. Aþaðýdaki sorguda yer alan hatalarý düzeltiniz? 
Select ProductType, * from FRG.Exchange ORDER BY 1 desc GROUP BY ProductType  
--* kaldýrýlmalý kolon isimleri group byýn içinde yazmalý selectin içinde kullandýðýmýz kolonlarý kullanmak istiyorsak.
--order by group by dan sonra kullanýlmalý 
Select ProductType, count(*)
from FRG.Exchange 
GROUP BY ProductType 
ORDER BY 1 desc 
--20. Aþaðýdaki Sales tablosunda ürünlere göre satýþ miktarlarýnýn toplamýný döndüren sorguyu yazýnýz? 
select Product_Id ,SUM(AMOUNT) from tSales
group by Product_Id 