--
--  sqlcmd -S. -i create-schema.sql
--

use st_zh;
go

drop   table if exists dbo.sd_zv_kitas_schulkreis;
go

drop   table if exists dbo.sd_zv_kitas_stadtquartier_imp;
go

drop   table if exists dbo.sd_zv_kitas_stadtquartier;
go

create table dbo.sd_zv_kitas_schulkreis (
   jahr             integer     ,
   skname           varchar( 50),
   anz_bp_sk        float,
   anz_kinder_va    float,
   belegungsfaktor  float,
   versorgungsquote float
);
go

create table dbo.sd_zv_kitas_stadtquartier_imp (
   qnr              varchar(100), -- integer     ,
   qname            varchar(100), -- varchar( 50),
   skname           varchar(100), -- varchar( 50),
   jahr             varchar(100), -- integer     ,
   anz_bp_sk        varchar(100), -- float       ,
   anz_kinder_va    varchar(100), -- float       ,
   belegungsfaktor  varchar(100), -- float       ,
   versorgungsquote varchar(100), -- float
);
go

create table dbo.sd_zv_kitas_stadtquartier (
   qnr              integer     ,
   qname            varchar( 50),
   skname           varchar( 50),
   jahr             integer     ,
   anz_bp_sk        float       ,
   anz_kinder_va    float       ,
   belegungsfaktor  float       ,
   versorgungsquote float
);
go
