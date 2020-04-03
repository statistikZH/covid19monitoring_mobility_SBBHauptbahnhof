# Mobility_SBBHauptbahnhof

# Import libraries
library(dplyr) # Version >= 0.8.5

# Number formatting
options(scipen = 1000000)
options(digits = 6)

# get and transform data function
getData <- function(url_dat)
{
      # import dat
    dat <- read.csv(url(url_dat), header=T, sep=";", stringsAsFactors=FALSE, encoding="UTF-8")
    
    #prepare dat
    dat_prep <- dat %>%
        transmute(
            'date' := as.POSIXct(paste(.data$Betriebstag, "00:00:00", sep=" "), format="%Y-%m-%d"),
            'value' := .data$Anzahl,
            'topic' := "Mobilität",
            'variable_short' := "oev_freq_hb",
            'variable_long' := "Anzahl Züge pro Haltestelle, Zählstelle Zürich Hauptbahnhof",
            'location' := "Zürich Hauptbahnhof",
            'unit' := "Anzahl",
            'source' := "SBB",
            'update' := "t\u00e4glich",
            'public' := "ja",
            'description' := "https://github.com/statistikZH/covid19monitoring_mobility_SBBHauptbahnhof"
        )
    
    # return
    return(dat_prep)
}

# main
url_dat <- "https://data.sbb.ch/explore/dataset/anzahl-zuge-pro-haltestelle/download/?format=csv&refine.bpuic=8503000&timezone=Europe/Berlin&lang=en&use_labels_for_header=true "
dat_prep <- getData(url_dat)
write.table(dat_prep, "./Mobility_SBBHauptbahnhof.csv", sep=",", fileEncoding="UTF-8", row.names = F)