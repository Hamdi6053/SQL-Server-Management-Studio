--1.	Bug�n�n tarihinin sadece y�l�n� d�nd�ren sorguyu yaz�n�z?
YEAR(GETDATE())
--2.	A�a��daki sorgudaki hatay� d�zeltiniz?

SELECT COUNT(*), Country
FROM Customers 
GROUP BY Country 
having COUNT(*) > 5

--3.	A�a��daki sorguda yer alan ko�ulu ba�ka nas�l yaz�labilir?
Select * from FRG.Exchange WHERE Amount BETWEEN 10000 and 20000 
select * from FRG.Exchange
where 10000<Amount<20000 
--4.	swf.SwiftJournal tablosunda SwiftId�si 5392228 olan kayd�n SwiftStatus��n� 9 olarak g�ncelleyen script�i yaz�n�z?
update swf.SwiftJournal
set
SwiftStatus = 9
where SwiftId = 5392228 
--5.	��stanbul T�rkiye� ifadesinde yer alan bo�luk karakterini / (sla�) ile de�i�tirerek getiren sorguyu yaz�n�z?
select replace('�stanbul T�rkiye',' ','/')

--6.	Bug�n�n tarihini Date tipinde d�nd�ren sorguyu yaz�n�z?
select convert(date,getdate())
--7.	A�a��daki tabloya g�re Company_Id�si 2�den b�y�k olan �irketlerin say�s�n� d�nd�re sorguyu yaz�n�z?
select Sum() from tCompanies
where company_ID > 2

--8.	7. Soruda yer alan tablolardan a�a��daki sorguyla d�nen kay�tlar� yaz�n�z?
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Name = AAA)
--Sonu� d�nd�rmez
--9.	7. Soruda yer alan tablolardan kategorisi 2 olmayan �r�nlerin firma isimleri en son kolonda olacak �ekilde listesini d�nd�ren sorguyu yaz�n�z? 
select C.Company_Name from tProducts as p
left join tCompanies as C
on p.Company_tCompanyID = C.ID
where p.Category != 2


--10.	A�a��daki sorguyu nas�l sadele�tirirsek sonu� hi� de�i�mez?
--Select ProductName from Products WHERE Company_Id = 4


--11.	7. Soruda yer alan tablolardan a�a��daki sorguyla d�nen kay�tlar� yaz�n�z?

Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Name = �DDDD�)
--Sonuc D�nd�rmez

--12.	7. Soruda yer alan Products tablosunda ka� farkl� firman�n �r�n� oldu�unu d�nd�ren sorguyu yaz�n�z
select COUNT(DISTINCT Company_�d) from tProducts


--13.	A�a��daki sorguda yer alan hatay� d�zeltiniz?
Select ProductName from Products WHERE Company_Id = (Select Company_Id from Companies where Company_Id > 1)


--14.	frg.ExchangeTransfer tablosunda yer alan kay�tlar� a�a��daki sorguyla g�ncellerken ne gibi bir risk vard�r?
UPDATE frg.ExchangeTransfer SET FEC = 1 
--Ko�ul yok ve t�m kay�tlar i�in 1 g�ncellemesini yap�yor.

--15.	Cus.Customer tablosunda ismi en uzun olan 3 m��terinin ismini d�nd�ren sorguyu yaz�n�z? (CustomerName)
select TOP 3 Company_Name from tCompanies 
ORDER BY len(Company_Name) DESC
--16.	FRG.Exchange tablosunda tutar� (Amount) 10000�den K���k olan tutarlar�n d�viz cinsine g�re ortalamas�n� azalan olarak d�nd�ren sorguyu yaz�n�z?



--17.	A�a��daki sorguda hangi ifadeyi ��karsak d�nen sonu� hi� de�i�mez?
Select TOP 100 * from swf.SwiftJournal ORDER BY 1 ASC
--ASCY� �IKARSAK DE���MEZ.

--18.	A�a��daki Sales tablosunda birim fiyat ortalamas�n�n �zerinde olan ka� farkl� �r�n oldu�unu d�nd�ren sorguyu yaz�n�z?
Sales
Id	Product_Id	Unit_Price	Quantity	Amount




--19.	Sales tablosunda birim fiyata (UnitPrice) % 18 Kdv eklenmi� ve artan �eklinde veri �ekilmek isteniyor, gerekli sorguyu yaz�n�z?
select (UnitPrice+0.18*UnitPrice) as 'KDV EKLENM�� HAL' from tSales as S 
ORDER BY (UnitPrice+0.18*UnitPrice) ASC
--20.	'1982-09-10' tarihinde do�an birinin ka� g�nd�r ya�ad���n� d�nd�ren sorguyu yaz�n�z?

select DATEDIFF(DAY,'1982-09-10',getdate())

