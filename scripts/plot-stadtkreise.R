library(rgdal)

stzh_data_root <- paste0 (Sys.getenv('USERPROFILE'),  '/github/github/data.stadt-zuerich.ch/');
stadtkreise    <- readOGR(paste0(stzh_data_root, 'dataset/stadtkreise'), 'Stadtkreis' );

par(mar=rep(0, 4));
plot(stadtkreise);
