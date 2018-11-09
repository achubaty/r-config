## ~/GitHub/r-config/R-devel/scripts/init-R-devel.sh
#!/bin/bash

## 1. install build dependencies
sudo apt-get build-dep r-base
sudo apt-get install ccache subversion xorg-dev -y

## 2. create necessary paths/file structure
mkdir -p ~/R
mkdir -p ~/GitHub/r-config/R-devel/src/
ln -sfn ~/GitHub/r-config/R-devel/src ~/R/src
mkdir -p ~/R/src/R-devel-build

## 3. get the R-devel source code
cd ~/R/src
svn co https://svn.r-project.org/R/trunk r-devel/R 

## 4. link the recommended packages
cd ~/R/src/r-devel/R
bash ./tools/rsync-recommended
bash ./tools/link-recommended

echo "*** Done -- now run 'build-R-devel.sh'"

