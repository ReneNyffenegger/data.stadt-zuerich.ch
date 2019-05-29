library(rgdal )
library(SPARQL)
library(raster)

stzh_data_root <- paste0 (Sys.getenv('USERPROFILE'),  '/github/github/data.stadt-zuerich.ch/');
stadtkreise    <- readOGR(paste0(stzh_data_root, 'dataset/stadtkreise'), 'Stadtkreis' );

endPointWikiData <- 'https://query.wikidata.org/sparql';

query <- '
  select
       ?fountain
       ?lat
       ?lon
  where
  {
    ?fountain      p:P528                ?statement     .
    ?statement     pq:P972                wd:Q53629101  .
    ?fountain      p:P625/psv:P625       ?coord         .
    ?coord         wikibase:geoLatitude  ?lat           .
    ?coord         wikibase:geoLongitude ?lon           .
  }
';


fountains <- SPARQL(endPointWikiData, query);

par(mar=rep(0, 4));
plot(stadtkreise);

coordinates(fountains$results) <- ~lon + lat
crs(fountains$results) <- CRS('+proj=longlat +datum=WGS84')
trx <- spTransform(fountains$results, crs(stadtkreise))
points(trx$lon, trx$lat, col='#3355ff', pch=16, cex = 0.4);

fountain_ <- identify(trx$lon, trx$lat, n = 1, plot = FALSE);
browseURL(gsub('<|>', '', fountains$results$fountain[fountain_]));
