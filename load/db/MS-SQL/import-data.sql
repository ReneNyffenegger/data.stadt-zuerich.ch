

--
--  sqlcmd -S. -v curDir="%CD%" -i import-data.sql
--

use st_zh;
go

-- bulk insert dbo.sd_zv_kitas_schulkreis
--    from '$(curDir)\..\..\..\dataset\sd_zv_kitas\sd_zv_kitas_schulkreis.csv'
-- -- from 'C:\Users\OMIS.Rene\github\github\data.stadt-zuerich.ch\dataset\sd_zv_kitas\sd_zv_kitas_schulkreis.csv'
-- with (
--    firstRow        =      2 ,
--    lastRow         =    118 ,
--    codepage        = '65001',
--    format          = 'CSV'  ,
--    fieldterminator = ','   
-- -- rowTerminator   = '0x0a',
-- -- DATAFILETYPE    = 'char'
-- );
-- go


bulk insert dbo.sd_zv_kitas_stadtquartier_imp
from '$(curDir)\..\..\..\dataset\sd_zv_kitas\sd_zv_kitas_stadtquartier.csv'
with (
   firstRow        =      2 ,
   lastRow         =    174 ,
   codepage        = '65001',
   format          = 'CSV'  ,
   fieldterminator = ','   
);
go

insert into dbo.sd_zv_kitas_stadtquartier
-- insert into dbo.sd_zv_kitas_stadtquartier
   select
      case when i.qnr       = '.' then null else i.qnr       end,
      i.qname            ,
      i.skname           ,
      i.jahr             ,
      case when i.anz_bp_sk = '.' then null else i.anz_bp_sk end,
      i.anz_kinder_va    ,
      i.belegungsfaktor  ,
      i.versorgungsquote  
   from
      dbo.sd_zv_kitas_stadtquartier_imp i;
--    openrowset (
--       bulk         '$(curDir)\..\..\..\dataset\sd_zv_kitas\sd_zv_kitas_stadtquartier.csv',
--       formatfile = '$(curDir)\sd_zv_kitas_stadtquartier.fmt',
--       firstRow   =      2,
--       lastRow    =    174,
--       codepage   = '65001'
--    ) as i;
-- 
go
