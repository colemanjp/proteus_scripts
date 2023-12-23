#!/bin/sh

echo "BROKEN"
exit 127

# paramspider dir
PS="${HOME}"/Projects/proteus_output/paramspider

# Timestamp
TSTAMP="${PS}"/paramspider.timestamp

# New hosts to scan
HOSTNEW="${PS}"/paramspider.host.txt.new

# Collect new hosts since last run
find "${HOME}"/.proteus/rawdata -newer "${TSTAMP}" -name host.txt.new  -exec cat {} \; > "${HOSTNEW}"

# Set timestamp for next run
touch "${TSTAMP}"

if [ -s "${HOSTNEW}" ]
then
	rm -rf "${PS}"/output
	axiom-scan "${HOSTNEW}" -m paramspider -o "${PS}"/output --rm-when-done --spinup 1
fi
	
# Log complete to discord
echo "paramspider.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
