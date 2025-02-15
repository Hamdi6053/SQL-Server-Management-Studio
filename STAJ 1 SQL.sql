select * from dbo.Bolgeler;

--select TerritoryTanimi from dbo.Bolgeler
--where TerritoryTanimi LIKE '%os%';

select TerritoryID from dbo.Bolgeler
where SUBSTRING(TerritoryID , 2, 2) = '34';

select dbo.Bolgeler.* , SUBSTRING(TerritoryID , 2, 2) AS Karakter from  dbo.Bolgeler;

ALTER TABLE dbo.Bolgeler
ADD Karakter AS SUBSTRING(TerritoryID , 2, 2);



SELECT *,
       CASE  
           WHEN Karakter = '52' THEN 'ORDU'
           WHEN Karakter = '41' THEN 'KOCAELÝ'
           WHEN Karakter = '28' THEN 'GÝRESUN'
           WHEN Karakter = '34' THEN 'ÝSTANBUL'
           WHEN Karakter = '54' THEN 'SAKARYA'
           ELSE 'PLAKA YOK'
       END AS KarakterDescription
FROM dbo.bolgeler;
 
 select * from dbo.Bolgeler
 Group By BolgeID;