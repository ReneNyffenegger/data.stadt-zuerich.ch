--
--  sqlcmd -S. -i create-schema.sql
--

use st_zh;
go

drop   table if exists dbo.sd_zv_kitas_schulkreis;
go

create table dbo.sd_zv_kitas_schulkreis (
   jahr             integer     , -- integer,
   skname           varchar(200),
   anz_bp_sq        float,
   anz_kinder_va    float,
   belegungsfaktor  float,
   versorgungsquote float
);
go
