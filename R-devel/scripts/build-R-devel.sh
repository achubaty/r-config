## ~/GitHub/r-config/R-devel/scripts/build-R-devel.sh
#!/bin/sh
mkdir -p ~/GitHub/r-config/R-devel/src
ln -sfn ~/GitHub/r-config/R-devel/src ~/R/src
mkdir -p ~/R/src/R-devel-build
cd ~/R/src/R-devel-build

# R_PAPERSIZE=letter                        \
# R_BATCHSAVE="--no-save --no-restore"      \
# R_BROWSER=xdg-open                        \
# PAGER=/usr/bin/pager                      \
# PERL=/usr/bin/perl                        \
# R_UNZIPCMD=/usr/bin/unzip                 \
# R_ZIPCMD=/usr/bin/zip                     \
# R_PRINTCMD=/usr/bin/lpr                   \
# LIBnn=lib                                 \
# AWK=/usr/bin/awk                          \
# CC="ccache gcc"                           \
# CFLAGS="-ggdb -pipe -std=gnu99 -Wall -pedantic -DTESTING_WRITE_BARRIER" \
# CXX="ccache g++"                          \
# CXXFLAGS="-ggdb -std=c++0x -pipe -Wall -pedantic" \
# FC="ccache gfortran"                      \
# FCFLAGS="-ggdb -pipe -Wall -pedantic"     \
# F77="ccache gfortran"                     \
# FFLAGS="-ggdb -pipe -Wall -pedantic"      \
# MAKE="make -j4"                           \
# ./configure                               \
#     --prefix=/usr/local/lib/R-devel       \
#     --enable-R-shlib                      \
#     --enable-strict-barrier               \
#     --with-blas                           \
#     --with-lapack                         \
#     --with-readline                       \
#     --with-recommended-packages           \
#     --program-suffix=dev

R_PAPERSIZE=letter                              \
R_BATCHSAVE="--no-save --no-restore"            \
R_BROWSER=xdg-open                              \
PAGER=/usr/bin/pager                            \
PERL=/usr/bin/perl                              \
R_UNZIPCMD=/usr/bin/unzip                       \
R_ZIPCMD=/usr/bin/zip                           \
R_PRINTCMD=/usr/bin/lpr                         \
LIBnn=lib                                       \
AWK=/usr/bin/awk                                \
CC="ccache gcc"                                 \
CFLAGS="-ggdb -pipe -std=gnu99 -Wall -pedantic" \
CXX="ccache g++"                                \
CXXFLAGS="-ggdb -pipe -Wall -pedantic"          \
FC="ccache gfortran"                            \
F77="ccache gfortran"                           \
MAKE="make"                                     \
../r-devel/R/configure                          \
    --prefix=/usr/local/lib/R-devel             \
    --enable-R-shlib                            \
    --with-blas                                 \
    --with-lapack                               \
    --with-readline                             \
    --with-recommended-packages                 \
    --with-tcltk                                \
    --program-suffix=devel

make

echo "*** Done -- now run 'make install'"
