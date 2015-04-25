### set CRAN mirror
    chooseCRANmirror()

### set default library path
    .libPaths("path/to/new/library/location")

### package groups
    data.manipulation <- c("data.table", "dplyr", "reshape")

    # development (devtools) for Windows requires `Rtools` from:
    #   http://cran.r-project.org/bin/windows/Rtools/index.html
    #   (this is a seperate install of an .exe file)
    development <- c("devtools", "magrittr", "memoise", "microbenchmark", "rbenchmark","Rcpp", "shiny")

    hpc <- c("bigmemory", "ff", "Rcpp", "Rdsm", "snowfall")

    # rgdal requires `sudo apt-get install libgdal-dev libgdal1-dev libproj-dev libspatialite-dev`
    # rgeos requires `sudo apt-get install libgeos-<version> libgeos-dev libgeos++-dev`
    # rgdal on OSX using homebrew: `brew install rgdal`
    mapping <- c("geoR", "mapdata", "maps", "maptools", "RandomFields", "plotKML", "rgdal", "rgeos",
                 "shapefiles", "sp", "spatstat", "raster", "rts")

    math.tools <- c("deSolve", "popbio")

    misc <- c("knitr", "random", "xtable")

    networks <- c("igraph", "sna")

    simulation.modelling <- c("GA", "Pomic")

    # Cairo requires: `sudo apt-get install libgtk2.0-dev libcairo2-dev libxt-dev xvfb xauth xfonts-base`
    # Diagrammer requires: `sudo apt-get install libv8-dev`
    plotting <- c("Cairo", "DiagrammeR", "ggplot2", "ggvis", "RColorBrewer", "scatterplot3d", "vioplot") # need to install `rCharts` from github

    stats.other <- c("boot", "CircStats", "effects", "lme4", "VGAM")

    all <- c(data.manipulation, development, hpc, mapping, math.tools, misc,
             networks, simulation.modelling, plotting, stats.other)
    all <- unique(all) # remove duplicate packages

### install packages
    install.packages(all); install_github("ramnathv/rCharts")
    install.packages(data.manipulation)
    install.packages(development)
    install.packages(hpc)
    install.packages(mapping)
    install.packages(math.tools)
    install.packages(misc)
    install.packages(networks)
    install.packages(simulation.modelling)
    install.packages(plotting); install_github("ramnathv/rCharts")
    install.packages(stats.mixed.effects)
    install.packages(stats.other)

### install other benchmarking tools
    devtools::install_github("lineprof")
    devtools::install_github("pryr")
    devtools::install_github("wch/shiny-slickgrid")
