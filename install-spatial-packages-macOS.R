# prerequisites -------------------------------------------------------------------------------

## brew install pkg-config
## brew install gdal
## brew install udunits

# package installation ------------------------------------------------------------------------

options(Ncpus = 8L)

## classInt won't compile on macOS w/o openssl, but it's not picking up the brew version
install.packages("classInt") # type = "source")

## s2 won't compile on macOS w/o fortran tools installed:
## 1. install e.g., <https://mac.r-project.org/tools/gfortran-12.2-universal.pkg>
## 2. create symlink to fortran binary:
##    `sudo ln -s /opt/gfortran/bin/gfortran /usr/local/bin/`
install.packages("s2") # type = "source")

## symlink below is temporary to account for proj.5 release (rgdal expects proj.4)
# file.symlink("/usr/local/opt/proj/lib/libproj.13.dylib",
#              "/usr/local/opt/proj/lib/libproj.12.dylib")
install.packages("sp", type = "source")
install.packages("https://cran.r-project.org/src/contrib/Archive/rgeos/rgeos_0.6-4.tar.gz", type = "source", repos = NULL)
install.packages("https://cran.r-project.org/src/contrib/Archive/rgdal/rgdal_1.6-7.tar.gz", type = "source", repos = NULL)
install.packages("units", type = "source",
                 configure.args = c("--with-udunits2-lib=$(brew --prefix)/lib/",
                                    "--with-udunits2-include=$(brew --prefix)/include/")
)
install.packages("sf", type = "source", configure.args = "--with-proj-lib=$(brew --prefix)/lib/")
install.packages("terra", type = "source")
install.packages("raster", type = "source")

## additional packages that depend on previous
install.packages("gdalUtils", type = "source")
install.packages("fasterize", type = "source")
