## ~/GitHub/r-config/R-devel/scripts/update-R-devel.sh
#!/bin/bash

# update source code
cd ~/R/src/r-devel/R
svn update
bash ./tools/rsync-recommended
bash ./tools/link-recommended

cd ~/GitHub/r-config/R-devel/scripts
bash ./build-R-devel.sh

# make and install
cd ~/GitHub/r-config/R-devel/src/R-devel-build
sudo make install

# update R packages
echo "*** Installation complete. Updating R packages..."
Rscript-devel -e 'install.packages("lattice", .Library.site[1])'
Rscript-devel -e 'update.packages(ask = FALSE, checkBuilt = TRUE, lib.loc = .Library.site[1])'
echo "*** Done."
