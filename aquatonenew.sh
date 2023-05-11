#!/bin/bash

PATH=$PATH:"$HOME"/.axiom/interact:"$HOME"/go/bin

SNEW="${HOME}"/Projects/proteus_output/screenshot.url.txt.new
SOUT="$HOME"/Projects/proteus_output/aquatone

# Collect new URLs last day
find "$HOME"/.proteus/rawdata -mtime -1 -name url.txt.new  -exec cat {} \; | sed -E 's/(:443|:80)//' > "${SNEW}"

# If the input file has something in it, run aquatone, fix aquatone output broken links
if [ -s "${SNEW}" ] 
    then 
        rm -rf "${SOUT}" && axiom-scan "${SNEW}" -m aquatone -o "${SOUT}" --quiet --fleet aquatone --spinup 1 --rm-when-done --rm-logs && sed -i -e 's%screenshots/%%g' -e 's%headers/%%g' -e 's%html/%%g' "${SOUT}"/aquatone_report.html
fi
	
# Log complete to discord
echo "aquatonenew.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
