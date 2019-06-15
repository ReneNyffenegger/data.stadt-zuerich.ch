--
-- set MYSQL_PWD=rene
-- "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u rene vbz_ogd < create-schema-vbz_ogd.sql

drop table if exists fahrzeiten_soll_ist;
drop table if exists haltepunkt         ;
drop table if exists haltestelle        ;

create table haltestelle (
   halt_id              integer        not null primary key,
   halt_diva            integer        not null unique     ,
   halt_kurz            varchar( 50)   not null unique     ,
   halt_lang            varchar(100)   not null,
   halt_ist_aktiv       bit            not null
   -- 
-- primary key (halt_id  ),
-- unique      (halt_diva)
);

create table haltepunkt (
   halt_punkt_id        integer       not null primary key,
   halt_punkt_diva      integer       not null,                                 -- TODO 
   halt_id              integer       not null references haltestelle(halt_id), -- There is a 1:n relationship between haltestelle and haltepunkt
   gps_latitude         double            null,
   gps_longitude        double            null,
   gps_bearing          integer           null check(gps_bearing between 0 and 360),
   halt_punkt_ist_aktiv bit           not null
);

create table fahrzeiten_soll_ist (
   id                     integer      not null auto_increment unique,
   linie                  integer      not null,
   richtung               integer      not null check (richtung in (1,2)),
   betriebsdatum          date         not null, -- In VBZ, a »betriebsdatum« starts at 5:00 (a.m). and lasts through 1:30 (a.m.))
   fahrzeug               integer      not null,
   kurs                   varchar( 20) not null,
   seq_von                integer      not null,
   halt_diva_von          integer      not null references haltestelle(halt_diva),
   halt_punkt_diva_von    integer      not null,
   halt_kurz_von1         varchar( 10) not null,
   datum_von              date         not null check(datum_von in (betriebsdatum, betriebsdatum+1)),
   soll_an_von            integer      not null check(soll_an_von <= 86400        ),
   ist_an_von             integer      not null,
   soll_ab_von            integer      not null,
   ist_ab_von             integer      not null,
   seq_nach               integer      not null,
   halt_diva_nach         integer      not null references haltestelle(halt_diva  ),
   halt_punkt_diva_nach   integer      not null,
   halt_kurz_nach1        varchar( 20) not null,
   datum_nach             date         not null check(datum_nach  >= betriebsdatum),
   soll_an_nach           integer      not null,
   ist_an_nach1           integer      not null,
   soll_ab_nach           integer      not null,
   ist_ab_nach            integer      not null,
   fahrt_id               integer      not null, -- Die VBZ-intern verwendete ID einer Fahrt pro Betriebstag
   fahrweg_id             integer      not null, -- Der VBZ-intern verwendete Fremdschlüssel zum Fahrwegstamm
   fw_no                  integer      not null, -- Die VBZ-intern verwendete Fahrwegnummer
   fw_typ                 integer      not null, -- Der VBZ-Intern verwendete Fahrwegtyp
   fw_kurz                integer      not null, -- Der VBZ-intern verwendete Fahrweg-Kurzcode
   fw_lang                varchar(100) not null,
   umlauf_von             integer      not null,
   halt_id_von            integer      not null references haltestelle(halt_id      ),
   halt_id_nach           integer      not null references haltestelle(halt_id      ),
   halt_punkt_id_von      integer      not null references haltepunkt (halt_punkt_id),
   halt_punkt_id_nach     integer      not null references haltepunkt (halt_punkt_id),
   --
   check (
      ( betriebsdatum     = datum_von and soll_ab_von > 15000) or
      ( betriebsdatum + 1 = datum_von and soll_ab_von >  6000)
   )
);
