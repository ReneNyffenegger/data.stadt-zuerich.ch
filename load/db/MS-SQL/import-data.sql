

--
--  sqlcmd -S. -v curDir="%CD%" -i import-data.sql
--

use st_zh;
go

bulk insert dbo.sd_zv_kitas_schulkreis
from '$(curDir)\..\..\..\dataset\sd_zv_kitas_schulkreis\sd_zv_kitas_schulkreis.csv'
with (
   firstRow        =      2 ,
   lastRow         =    109 ,
   codepage        = '65001',
   format          = 'CSV'  ,
   fieldterminator = ','   
-- rowTerminator   = '0x0a',
-- DATAFILETYPE    = 'char'
);
go
