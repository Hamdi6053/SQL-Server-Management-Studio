--1. Bug�n�n tarihine ay ekledikten sonraki tarihi d�nd�ren sorguyu yaz�n�z? 
select dateadd(MONTH,1,GETDATE()) as 'Eklenmi� Hal'
--2. Products tablosunda birim fiyat� (UnitPrice) 100 TL�den b�y�k olan �r�nlere %10 zam yap�lacak 100 TL olan ve 
--daha d���k olan �r�nlere %20 zam yap�lacakt�r. Her bir �r�n� ve bu �r�nlerin zaml� birim fiyat�n� d�nd�ren 
--sorguyu yaz�n�z?  
SELECT 
product_name,
     CASE
	     when unitprice>100 then (unitprice+0.1*unitprice),
		 when unitprice<= 100 then (unitprice+0.2*unitprice),
		 else 
	 End as 'zaml� birim fiyat'
from tProducts

--3. A�a��daki sorguda yer alan hatalar� d�zeltiniz? 
Select IIF(Age < 35, 'Gen�', 'Orta Ya�l�') as Gen� Mi * from Employee ORDER BY Id DES 
--D�zeltilmi�
Select IIF(Age<35, 'Gen�', 'Orta Ya�l�') as 'Gen� Mi' , * from Employee 
Order by ID DESC

--4. Status�� 1 olan veya isProcessed�i 0 olan kay�tlar�n MessageType��n� �MT199� ve MtId�sini 9876543 
--olarak g�ncelleyen script�i yaz�n�z? 
UPDATE tTabloAdi
Set
MessageType = 'MT199' , MtID = 9876543
where Stat�s = 1 OR isProcessed = 0

--5. Employee tablosunda Cinsiyeti K olan personellerin isminin (EmployeeName) sonuna � Han�m,� ve E olan 
--personellerin isminin sonuna � Bey,�  getiren sorguyu yaz�n�z? 
SELECT 
    Personel_Name + 
    CASE 
        WHEN Cinsiyet = 'K' THEN ' Han�m'
        WHEN Cinsiyet = 'E' THEN ' Bey'
        ELSE ' De�erlendirme d���'
    END AS Updated_Name
FROM tEmployee;


--6. Hangi �r�n hangi kategoride d�nd�ren sorguyu yaz�n�z? 

select Product_Name,Category from tProdects

--7. Alt�nda �r�n bulunmayan kategorileri d�nd�ren sorguyu yaz�n�z? 
select * from tProducts


--8. Hi� sipari� vermemi� olan m��terileri d�nd�ren sorguyu yaz�n�z? 
--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID 

 select CustomerName from tCustomers as C
 left join tOrders  As O
 ON C.ID = O.Customer_tCustomerID
 where O.OrderID is null

-- 9. Sorudaki tablolar� baz alarak �ehri �stanbul olan m��terilerden elde edilen gelirlerin toplam�n� d�nd�ren 
--sorguyu yaz�n�z? (Adet baz�nda)

select C.CustomerName,Sum(O.Amount) from tCustomers as C
left join tOrders as O
on C.ID = O.Customer_tCustomerID
where C.City = '�stanbul'
group by C.CustomerName 

select Sum(O.Amount) from tCustomers as C
left join tOrders as O
on C.ID = O.Customer_tCustomerID
where C.City = '�stanbul'


-- 10.her bir m��terinin �r�n baz�nda ka� tane sipari� 
--verdi�ini d�nd�ren sorguyu yaz�n�z? 

--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID 
select  C.CustomerName,ProductID,count(O.OrderID) from tOrders as O
left join tCustomers as C
on o.Customer_tCustomerID = C.ID 
group by C.CustomerName,ProductID

--11. 9. Sorudaki tablolar� baz alarak 2022 y�l�nda en �ok sat�� yapan personel id�sini d�nd�ren sorguyu yaz�n�z? 
--CustomerID ,CustomerName ,ContactName, Address, City, PostalCode, Country 
 --OrderID CustomerID ProductsID EmployeeID OrderDate Amount ShipperID


--12. En �ok sat�� yapan �� personele yapt�klar� sat�� tutar� �zerinden % 5 pirim verilecektir, hangi personellere ne 
--kadar pirim verilece�ini d�nd�ren sorguyu yaz�n�z? 




--13. A�a��daki tabloya g�re Company_Id�si 50�den b�y�k ve 300�den k���k olan �irketlerin isminde �a� ge�en 
--�irketlerin adreslerini d�nd�ren sorguyu yaz�n�z? 
select Company_Address  from tCompanies as C
where 50 < C.Company_�d < 300 and C.Company_Name like '%a%'

--14. 13. Soruda yer alan tablolardan a�a��daki sorguyla d�nen kay�tlar� yaz�n�z? 
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where 
Company_Name like �Bostanc��) 

-- Sonu� d�nd�rmez 

--15. 13. Soruda yer alan tablolardan kategorisi 2 olan �r�nlerin firma isimlerini d�nd�ren sorguyu yaz�n�z?  

select Company_Name from tCompanies as C
left join tProducts as P
on C.ID = P.Company_tCompanyID
where P.Category = 2 


--16. 13. Soruda yer alan tablolardan a�a��daki sorguyla d�nen kay�tlar� yaz�n�z? 
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where 
Company_Address like �%a%�)

--Bigisayar,Buzdolab�,Sehpa,Battaniye 

--17. 13. Soruda yer alan Products tablosunda ka� farkl� firman�n �r�n� oldu�unu d�nd�ren sorguyu yaz�n�z?

select COUNT(DISTINCT COMPANY_ID) from tProducts


--18. A�a��daki iki sorgu sonucu aras�nda bir fark var m�d�r? 
Select * from FRG.Exchange where Reference = '70VK24000' 
Select * from FRG.Exchange where Reference like '70VK24000' 

--Evet var biri direkt o h�crenin i�in '70VK24000' bundan ge�en yani like 
--Di�eri ise direkt buna e�it olan reference kolonunu arar yani in komutu
--Farkl� iki sorgu ��kt�s� farkl� olacakt�r.


--19. A�a��daki sorguda yer alan hatalar� d�zeltiniz? 
Select ProductType, * from FRG.Exchange ORDER BY 1 desc GROUP BY ProductType  
--* kald�r�lmal� kolon isimleri group by�n i�inde yazmal� selectin i�inde kulland���m�z kolonlar� kullanmak istiyorsak.
--order by group by dan sonra kullan�lmal� 
Select ProductType, count(*)
from FRG.Exchange 
GROUP BY ProductType 
ORDER BY 1 desc 
--20. A�a��daki Sales tablosunda �r�nlere g�re sat�� miktarlar�n�n toplam�n� d�nd�ren sorguyu yaz�n�z? 
select Product_Id ,SUM(AMOUNT) from tSales
group by Product_Id 