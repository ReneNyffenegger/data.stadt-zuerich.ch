x11()

library(rgdal)

stzh_data_root = paste0(Sys.getenv('USERPROFILE'),  '\\github\\data.stadt-zuerich.ch\\')
# stzh_data_root = paste0(Sys.getenv('USERPROFILE'),  '\\github\\github\\data.stadt-zuerich.ch\\') # Laptop

stadtkreise         <- readOGR (paste0(stzh_data_root, 'dataset/stadtkreise'              )                     , 'Stadtkreis'                                   )
stat_quartiere      <- readOGR (paste0(stzh_data_root, 'dataset/statistisches-quartier'   )                     , 'StatistischesQuartier'                        )
statistische_zone   <- readOGR (paste0(stzh_data_root, 'dataset/statistische_zone'        )                     , 'StatistischeZone'                             )
zweiradabstellplatz <- readOGR (paste0(stzh_data_root, 'dataset/zweiradabstellplatz'      )                     , 'Zweiradabstellplatz'                          )
fussweg             <- readOGR (paste0(stzh_data_root, 'dataset/fussweg'                  )                     , 'Fussweg'                                      )
parkverordnung2010  <- readOGR (paste0(stzh_data_root, 'dataset/parkplatzverordnung2010'  )                     , 'Parkplatzverordnung2010'                      )
parkgebuehr         <- readOGR (paste0(stzh_data_root, 'dataset/parkierungsgebuehren'     )                     , 'Parkierungsgebuehren'                         )
wahlkreis           <- readOGR (paste0(stzh_data_root, 'dataset/wahlkreis'                )                     , 'Wahlkreis'                                    )
landpreiszone       <- readOGR (paste0(stzh_data_root, 'dataset/landpreiszone'            )                     , 'Landpreiszone'                                )
fahrverbotszone     <- readOGR (paste0(stzh_data_root, 'dataset/fahrverbotszone'          )                     , 'Fahrverbotszone'                              )
adressen            <- readOGR (paste0(stzh_data_root, 'dataset/adressen'                 )                     , 'Adressen'                                     )

#
summary(stadtkreise)

# Geometry error:
# vk_zaehl_standort   <- readOGR ('../dataset/verkehrszaehlungen-standorte-velo-fussgaenger'  , 'Verkehrszaehlungen_Standorte_Velo_Fussgaenger')
  
einkommen_quartier  <- read.csv('../dataset/fd_median_einkommen_quartier_od1003/wir100od1003.csv'      )
vermoegen_quartier  <- read.csv('../dataset/fd_median_vermoegen_quartier_od1004/wir100od1004.csv'      )
stockwerk_eigentum  <- read.csv('../dataset/bau-bautaetigkeit-neu-erstelltes-stockwerkeigentum/neuerststweigentquartseit2001.csv', sep=';')
wohnungen           <- read.csv('../dataset/bau-bestand-wohnungen-nach-gebaeudeart-stockwerk-und-quartier/t936.csv', encoding='latin1')
kitas               <- read.csv('../dataset/sd_zv_kitas_schulkreis/sd_zv_kitas_schulkreis.csv')
abstimmungen_s_1933 <- read.csv('../dataset/politik-abstimmungen-seit-1933/abstimmungen_seit1933.csv')

# Stadtquartiere

plot(stat_quartiere)


#
# Parkgebuehren
#
plot(stadtkreise, main = 'Mo-Mi 9-20, Do-So 9-9')
plot(parkgebuehr[parkgebuehr$bedienungs == 'Montag - Mittwoch, 9:00 - 20:00 Uhr, Donnerstag - Sonntag, 9:00 - 9:00 Uhr', ], col='red', add=TRUE)
dummy <- locator(1)

plot(stadtkreise, main = 'Hochtarifzone')
plot(parkgebuehr[parkgebuehr$tarifzone == 'Hochtarifzone'  , ], col='red' , add=TRUE)
dummy <- locator(1)

plot(stadtkreise, main = 'Zürich West/Innenstadt u. Oerlikon')
plot(subset(parkgebuehr, zone_bezei == 'Zürich-West'            ), col='red' , add=TRUE)
plot(subset(parkgebuehr, zone_bezei == 'Innenstadt und Oerlikon'), col='blue', add=TRUE)
# plot(parkgebuehr[parkgebuehr$tarifzone == 'Niedertarifzone', ], col='blue', add=TRUE)
dummy <- locator(1)

#
# Fussweg
#
plot(stadtkreise)
plot(subset(fussweg, FAHRRAD==1), col='red' , add=TRUE)
plot(subset(fussweg, FAHRRAD!=1), col='blue', add=TRUE)

#
# Adressen
#
plot(stadtkreise)
plot(subset(adressen, adresse == 'Aargauerstrasse 1'), pch=16, col='red'  , cex=2, add=TRUE)
plot(subset(adressen, adresse == 'Josefstrasse 207b'), pch=16, col='blue' , cex=2, add=TRUE)
plot(subset(adressen, adresse == 'Toblerstrasse 57' ), pch=16, col='green', cex=2, add=TRUE)
dummy <- locator(1)

plot(statistische_zone)
# plot(stadtkreise)
plot(adressen[is.na(adressen$art), ], cex=0.2, pch=16, col='#ff9933', add=TRUE)
dummy <- locator(1)

#
# Parkplatzverordnung2010
#
plot(stadtkreise, main='Parkplatzverordnung 2010')
plot(subset(parkverordnung2010, gebiet == 'A'             ), col='#ff0000' , add=TRUE)
plot(subset(parkverordnung2010, gebiet == 'B'             ), col='#ee4411' , add=TRUE)
plot(subset(parkverordnung2010, gebiet == 'C'             ), col='#dd6633' , add=TRUE)
plot(subset(parkverordnung2010, gebiet == 'D'             ), col='#cc8855' , add=TRUE)
plot(subset(parkverordnung2010, gebiet == 'übriges Gebiet'), col='#bb7777' , add=TRUE)
plot(subset(fussweg, FAHRRAD!=1), col='blue', add=TRUE)

#
# Beleuchtung
#
#   Following causes error with rgdal package
#
# beleuchtung         <- readOGR ('../dataset/beleuchtung'           , 'Beleuchtung'          )
#
  library(maptools)
  beleuchtung       <- readShapePoints ('../dataset/beleuchtung/Beleuchtung.shp')
  plot(beleuchtung)

#
#  Abstimmungen
#
#  Klares Ergebnis
#    Note the dots in the name of column Ja....
#
abstimmungen_s_1933[abstimmungen_s_1933$Ja.... > '97.0', ]


#
#  Kitas
#
kita_gesamt = kitas$Skname == 'Gesamte Stadt'
plot(kitas$Jahr[kita_gesamt],
     kitas$Anz_Kinder_VA[kita_gesamt], col='red', pch=16,
     ylim=c(0, max(kitas$Anz_Kinder_VA[kita_gesamt]))      # extend y axis from 0 to top
    )
points(kitas$Jahr[kita_gesamt],
       kitas$Anz_BP_SQ[kita_gesamt], col='blue', pch=16)

par(new=TRUE)       # Adding a new plot because the y-axis changes.

plot ( type='l',
       lwd=  3 ,
       col='green',
       kitas$Jahr[kita_gesamt],
       kitas$Anz_BP_SQ[kita_gesamt]/
       kitas$Anz_Kinder_VA[kita_gesamt],
       ylim = c(0, 0.5),
       axes = FALSE,      # Don't write axis
       xlab = NA,
       ylab = NA
      )
axis(side=4)

#
#  Einkommen in Quartieren
#

plot(einkommen_quartier$SteuerEinkommen_p50[einkommen_quartier$SteuerTarifSort == 0 & einkommen_quartier$SteuerJahr==2015],
     einkommen_quartier$SteuerEinkommen_p50[einkommen_quartier$SteuerTarifSort == 1 & einkommen_quartier$SteuerJahr==2015],
     pch = einkommen_quartier$QuarSort %% 31,
     col = 2 # einkommen_quartier$SteuerJahr
    )

#
#  Vermoegen in Quartieren
#

v_2011        = vermoegen_quartier$SteuerJahr      == 2011
v_tarif_grund = vermoegen_quartier$SteuerTarifSort ==    0
v_tarif_verh  = vermoegen_quartier$SteuerTarifSort ==    1
v_tarif_1_elt = vermoegen_quartier$SteuerTarifSort ==    2

v_quarters    = vermoegen_quartier$QuarSort %in% c(11, 12, 13, 14, 15, 16, 17, 18, 19, 20)

cond = v_2011 & v_quarters
cond = v_2011 

plot  (vermoegen_quartier$SteuerVermoegen_p50[cond & v_tarif_grund],
       vermoegen_quartier$SteuerVermoegen_p50[cond & v_tarif_verh ], col='red' , pch=16)

points(vermoegen_quartier$SteuerVermoegen_p50[cond & v_tarif_grund],
       vermoegen_quartier$SteuerVermoegen_p50[cond & v_tarif_1_elt], col='blue', pch=16)

#
#  Landpreiszonen
#

                                                                                # Landpreiszone    |  Bandbreite CHF / m²
plot(stadtkreise, lwd=5, col='#eeeeff')
plot(landpreiszone[landpreiszone$lpz_typ == '1a', ], col = '#ff0000', add=TRUE) # Exklusive Lage   |  50'000  - …
plot(landpreiszone[landpreiszone$lpz_typ == '1b', ], col = '#dd2200', add=TRUE) #                  |  35'000  - 50'000
plot(landpreiszone[landpreiszone$lpz_typ == '2' , ], col = '#cc3344', add=TRUE) # sehr gute Lage   |  25'000  - 35'000
plot(landpreiszone[landpreiszone$lpz_typ == '3a', ], col = '#bb4499', add=TRUE) # gute Lage        |  18'000  - 25'000
plot(landpreiszone[landpreiszone$lpz_typ == '3b', ], col = '#9966aa', add=TRUE) #                  |  11'000  - 18'000
plot(landpreiszone[landpreiszone$lpz_typ == '4a', ], col = '#5588cc', add=TRUE) # mittlere Lage    |   7'000  - 11'000
plot(landpreiszone[landpreiszone$lpz_typ == '4b', ], col = '#44aadd', add=TRUE) #                  |   3'500  -  7'000
plot(landpreiszone[landpreiszone$lpz_typ == '5a', ], col = '#2299ee', add=TRUE) # übrige Lage      |   2'300  -  3'500
plot(landpreiszone[landpreiszone$lpz_typ == '5b', ], col = '#0077ff', add=TRUE) #                  |   1'000  -  2'300
dummy <- locator(1)


# 
#  Fahrverbotszonen
#
plot(stadtkreise, lwd=5, col='#eeeeff')
plot(fahrverbotszone[fahrverbotszone$bestehend == 1, ], col='#ff7733', add=TRUE)
plot(fahrverbotszone[fahrverbotszone$bestehend == 0, ], col='#bb5544', add=TRUE)
dummy <- locator(1)

#
#  Statistische Zonen
#
#    Zonen
plot(statistische_zone, col=statistische_zone$stznr)
dummy <- locator(1)

#    Quartier
plot(statistische_zone, col=statistische_zone$qnr)
dummy <- locator(1)

# plot(wahlkreis)
# dummy <- locator(1)

# Draw Zųrich without administrative borders:
plot(stadtkreise, lwd=5, col='#eeeeff')
plot(stadtkreise, lty=0, col='#eeeeff', add=TRUE)

dummy <- locator(1)


# show stadkreis 7
plot(stadtkreise[stadtkreise@data$knr == 7, ], col=3, add=TRUE)
dummy <- locator(1)

plot(stadtkreise[stadtkreise@data$knr == 4, ], col=2, add=TRUE)
dummy <- locator(1)
q();

# plot(stadtkreise[stadtkreise@data$knr = 1 , col=stadtkreise@data$knr)

#
# Show values
#
str(zweiradabstellplatz@data)

plot(stadtkreise, col='#eeeeff', main='Zweiradabstellplätze')
gedeckt = zweiradabstellplatz@data$dach == 'gedeckt'

#
# pch 16 = filled circle
#
plot(zweiradabstellplatz[  gedeckt, ], pch=16, cex=zweiradabstellplatz@data$anzahl_pp/200 , col='#ff5533', add=TRUE)
plot(zweiradabstellplatz[! gedeckt, ], pch=16, cex=zweiradabstellplatz@data$anzahl_pp/200 , col='#5533ff', add=TRUE)
dummy <- locator(1)

lod0 <- readOGR('../dataset/3d-terrainmodell-lod0/Terrain_LoD0_TIN.gdb', 'TIN_STANDARD')


#
# ---------------------------------------
#
# Plot swiss coordinates onto map.
#
  par(mar=c(0, 0, 0, 0))
  plot(stadtkreise)
  anInterestingPoint <- data.frame( x = c(2687148),  y = c(1245994) )
  coordinates(anInterestingPoint) <- ~x+y
  #
  #   make sure the two files share the same CRS (Coordinate Reference System)
  #
  anInterestingPoint@proj4string = stadtkreise@proj4string

  points(anInterestingPoint, col='red', pch=16, cex=2)

  moreInterestingPoints <- data.frame( 
        x = c(2686200, 2681400, 2683800 ) ,
        y = c(1246000, 1252500, 1252200 )
  )
  coordinates(moreInterestingPoints) <- ~x+y
  points(moreInterestingPoints, col='blue', cex=2)
