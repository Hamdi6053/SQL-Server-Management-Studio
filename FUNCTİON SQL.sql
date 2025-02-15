create function func_BuyukHarf(@gelendeger varchar(20))
returns varchar(10)
as
begin 
return upper(@gelendeger)
end

Create Function Degistir(@ad varchar(20), @soyad varchar(20))
returns varchar(20)
as
begin
return Substring(@ad,1,1) +'.'+upper(@soyad)
end

Select dbo.Degistir(ograd,ogrsoyad) From Ogrenci