### set CRAN mirror
    chooseCRANmirror()

### package groups
    data.manipulation <- c("plyr", "reshape")
    
    # development (devtools) for Windows requires `Rtools` from:
    #   http://cran.r-project.org/bin/windows/Rtools/index.html
    #   (this is a seperate install of an .exe file)
    development <- c("devtools", "memoise", "microbenchmark", "rbenchmark","Rcpp", "shiny")
    
    hpc <- c("bigmemory", "ff", "Rcpp", "Rdsm", "snowfall")
    
    # mapping (rgeos) requires `sudo apt-get install libgeos-<version> libgeos-dev libgeos++-dev`
    mapping <- c("geoR", "mapdata", "maps", "maptools", "RandomFields", "rgdal", "rgeos",
                 "shapefiles", "sp", "spatstat", "raster")
    
    math.tools <- c("deSolve", "popbio")
    
    misc <- c("xtable")
    
    networks <- c("igraph", "sna")
    
    simulation.modelling <- c("GA", "Pomic")
    
    plotting <- c("ggplot2", "grid", "manipulate", "RColorBrewer", "scatterplot3d", "vioplot")
    
    stats.mixed.effects <- c(lme4, nlme)
    
    stats.other <- c("boot", "CircStats", "effects", "MASS", "survival", "VGAM")

### install packages
    install.packages(data.manipulation)
    install.packages(development)
    install.packages(hpc)
    install.packages(mapping)
    install.packages(math.tools)
    install.packages(misc)
    install.packages(networks)
    install.packages(pattern.oriented.modelling)
    install.packages(plotting)
    install.packages(stats.mixed.effects)
    install.packages(stats.other)

### install other benchmarking tools
    devtools::install_github("lineprof")
    devtools::install_github("pryr")
    devtools::install_github("shiny-slickgrid", "wch")
