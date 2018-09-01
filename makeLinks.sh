# makeLinks.sh
# Author: Carl
# Purpose: Install symlinks into ~/usr/bin from this folder

ln -s $(pwd)/gitRepoDmenu.sh ~/usr/bin/gitMenu
ln -s $(pwd)/glDocsDmenu.sh ~/usr/bin/glMenu
ln -s $(pwd)/screenshotMode.sh ~/usr/bin/shotmode
ln -s $(pwd)/workMode.sh ~/usr/bin/workmode
ln -s $(pwd)/externalMonitor.sh ~/usr/bin/conmon

