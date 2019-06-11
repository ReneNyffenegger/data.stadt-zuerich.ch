--
-- sqlplus -S st_zh/st_zh@ora18 @create-schema
--

drop table adressen_import purge;

create table adressen_import (
   art                       varchar2(100),
   lokalisationsname         varchar2(100),
   hausnummer                varchar2(100),
   hausnummer_sort           varchar2(100),
   adresse                   varchar2(100),
   gwr_egid                  varchar2(100),
   plz                       varchar2(100),
   stadtkreis                varchar2(100),
   statistisches_quartierr   varchar2(100),
   statistische_zone         varchar2(100),
   schulkreis                varchar2(100),
   verwaltungsquartier       varchar2(100),
   roem_kath_kirchgemeinde   varchar2(100),
   ev_ref_kirchgemeinde      varchar2(100),
   easting                   varchar2(100),
   northing                  varchar2(100),
   eeasting_wgs              varchar2(100),
   northing_wgs              varchar2(100)
);


-- comment on column adressen.art                is 'Dieses Attribut beschreibt auf welchem Niveau sich ein Gebäude befindet. Mögliche Werte sind: "unterirdisches_Gebaeude", "Unterstand" oder null.';
-- comment on column adressen.gwr_egid           is 'Eidgenössischer Gebäudeidentifikator. GWR = Gebäude- und Wohnungsregister (verwalted vom Bundesamt für Statistik).';

exit;
