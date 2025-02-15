alter table tMusteriler
add KayitZamani2 smalldatetime; /* var olan bir tabloya bir kolon ekledik*/

alter table tMusteriler
alter column KayitZamani2 datetime; /* var olan bir kolonun veri türünü deðiþtirdik*/

/*alter table tMusteriler
add constraint unique_tmusterilercepTel unique(CepTel)
add constraint iliski_tmusterile_ foreign key (CepTel) 
references tKanGruplari(Adi); */                             
	   
exec sp_rename 'tMusteriler' ,'tMusteriler2' /* tablonun ismini deðiþtirdik*/

exec sp_rename 'tMusteriler2.telNo', 'CepTelefonu', 'COLUMN';

update tMusteriler2 set 
Adi = 'Alperen'
Soyadi = 'Ateþ'
where ID = 5 ;