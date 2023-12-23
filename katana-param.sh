#!/bin/bash

PATH=$PATH:"${HOME}"/.axiom/interact:"${HOME}"/go/bin

# katana dir
PS="${HOME}"/Projects/proteus_output/katana

# Timestamp
TSTAMP="${PS}"/katana-param.timestamp

# New URLs to scan
URLNEW="${PS}"/katana-param.url.txt.new

# New katana-param output
KPNEW="${PS}"/katana-param.new

# katana-param running list
KPRUNNING="${PS}"/katana-param.running.txt

# Collect new URLs since last run
find "${HOME}"/.proteus/rawdata -newer "${TSTAMP}" -name url.txt.new  -exec cat {} \; > "${URLNEW}"

# Set timestamp for next run
touch "${TSTAMP}"

if [ -s "${URLNEW}" ]
then
	axiom-scan "${URLNEW}" -m katana -field qurl -o "${KPNEW}" --fleet katana-param --rm-when-done --spinup 1
	${HOME}/Projects/proteus_output/scripts/nuclei-fuzz.sh
fi

anew "${KPRUNNING}" <"${KPNEW}" 
	
# Log complete to discord
echo "katana-param.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
