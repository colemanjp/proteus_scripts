#!/bin/sh

# paramspider dir
PS="${HOME}"/Projects/proteus_output/paramspider

# Timestamp
TSTAMP="${PS}"/paramspider.timestamp

# New URLs to scan
URLNEW="${PS}"/paramspider.url.txt.new

# Collect new URLs since last run
find "${HOME}"/.proteus/rawdata -newer "${TSTAMP}" -name url.txt.new  -exec cat {} \; > "${URLNEW}"

# Set timestamp for next run
touch "${TSTAMP}"

if [ -s "${URLNEW}" ]
then
	rm -rf "${PS}"/output
	axiom-scan "${URLNEW}" -m paramspider -o "${PS}"/output --rm-when-done --spinup 1
fi
	
# Log complete to discord
echo "paramspider.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
