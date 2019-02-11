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
