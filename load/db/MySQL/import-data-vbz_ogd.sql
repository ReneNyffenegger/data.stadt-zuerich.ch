--
-- set MYSQL_PWD=rene
-- "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" --skip-column-names --show-warnings --local-infile -u rene vbz_ogd < import-data-vbz_ogd.sql

set session sql_mode = 'strict_trans_tables,no_engine_substitution,traditional';

set foreign_key_checks = 0;

truncate table fahrzeiten_soll_ist;
truncate table haltepunkt         ;
truncate table haltestelle        ;

select concat(now(), ': Loading haltestelle'); -- {{{

load data local infile '../../../dataset/vbz_fahrzeiten_ogd/haltestelle.csv'
  into table           haltestelle
  fields terminated    by ',' 
  optionally enclosed  by '"'
  lines terminated     by '\r\n'
  ignore 1 rows
(
   halt_id        ,
   halt_diva      ,
   halt_kurz      ,
   halt_lang      ,
  @halt_ist_aktiv  
)
set
   halt_ist_aktiv = case when @halt_ist_aktiv = 'True' then 1 else 0 end
;

select concat('count(haltestelle) = ', count(*)) from haltestelle  having count(*) != 730;
-- vi: foldmethod=marker foldmarker={{{,}}}

-- }}}
select concat(now(), ': Loading haltepunkt'); -- {{{

load data local infile '../../../dataset/vbz_fahrzeiten_ogd/haltepunkt.csv'
  into table           haltepunkt
  fields terminated    by ',' 
  optionally enclosed  by '"'
  lines terminated     by '\r\n'
  ignore 1 rows
(
   halt_punkt_id        ,
   halt_punkt_diva      ,
   halt_id              ,
  @gps_latitude         ,
  @gps_longitude        ,
  @gps_bearing          ,
  @halt_punkt_ist_aktiv
)
set
   gps_latitude         = case when @gps_latitude         = ''     then null else @gps_latitude  end,
   gps_longitude        = case when @gps_longitude        = ''     then null else @gps_longitude end,
   gps_bearing          = case when @gps_bearing          = ''     then null else @gps_bearing   end,
   halt_punkt_ist_aktiv = case when @halt_punkt_ist_aktiv = 'True' then 1    else  0             end
;

select concat('count(haltepunkt) = ', count(*)) from haltepunkt  having count(*) != 17636;
-- }}}
select concat(now(), ': Loading fahrzeiten_soll_ist'); -- {{{

-- set @id := 0;

load data local infile '../../../dataset/vbz_fahrzeiten_ogd/fahrzeiten_soll_ist_20190505_20190511.csv'
  into table           fahrzeiten_soll_ist
  fields terminated    by ',' 
  optionally enclosed  by '"'
  lines terminated     by '\r\n'
  ignore 1 rows
(
   linie                  ,
   richtung               ,
  @betriebsdatum          ,
   fahrzeug               ,
   kurs                   ,
   seq_von                ,
   halt_diva_von          ,
   halt_punkt_diva_von    ,
   halt_kurz_von1         ,
  @datum_von              ,
   soll_an_von            ,
   ist_an_von             ,
   soll_ab_von            ,
   ist_ab_von             ,
   seq_nach               ,
   halt_diva_nach         ,
   halt_punkt_diva_nach   ,
   halt_kurz_nach1        ,
  @datum_nach             ,
   soll_an_nach           ,
   ist_an_nach1           ,
   soll_ab_nach           ,
   ist_ab_nach            ,
   fahrt_id               ,
   fahrweg_id             ,
   fw_no                  ,
   fw_typ                 ,
   fw_kurz                ,
   fw_lang                ,
   umlauf_von             ,
   halt_id_von            ,
   halt_id_nach           ,
   halt_punkt_id_von      ,
   halt_punkt_id_nach     
)
set
-- id            = @id := @id + 1                          ,
   betriebsdatum =  str_to_date(@betriebsdatum, '%d.%m.%y'),
   datum_von     =  str_to_date(@datum_von    , '%d.%m.%y'),
   datum_nach    =  str_to_date(@datum_nach   , '%d.%m.%y')
;

select concat('count(fahrzeiten_soll_ist) = ', count(*)) from fahrzeiten_soll_ist  having count(*) != 1430717;
-- }}}

select concat(now(), ' set foreign_key_checks = 1') msg;
set foreign_key_checks = 1;

select concat(now(), ' END') msg;
