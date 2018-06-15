## ~/GitHub/r-config/R-devel/scripts/R-devel.sh
#!/bin/bash
#export R_LIBS_SITE=${R_LIBS_SITE-'/usr/local/lib/R-devel/lib/R/library:/usr/local/lib/R/site-library:/usr/lib/R/site-library'}
export R_LIBS_SITE=${R_LIBS_SITE-'/usr/local/lib/R-devel/lib/R/library'}
export PATH="/usr/local/lib/R-devel/bin:$PATH"
R "$@"

