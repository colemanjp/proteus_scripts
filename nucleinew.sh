#!/bin/bash

PATH=$PATH:"${HOME}"/.axiom/interact:"${HOME}"/go/bin

# Timestamp
TSTAMP="${HOME}"/Projects/proteus_output/nuclei.timestamp
# New URLs to scan
URLNEW="${HOME}"/Projects/proteus_output/nuclei.url.txt.new
# New nuclei output
NNEW="${HOME}"/Projects/proteus_output/nuclei.new

# Collect new URLs since last run
find "${HOME}"/.proteus/rawdata -newer "${TSTAMP}" -name url.txt.new  -exec cat {} \; > "${URLNEW}"

# Set timestamp for next run
touch "${TSTAMP}"

# If the input file has something in it, run nuclei
if [ -s "${URLNEW}" ]; then axiom-scan "${URLNEW}" -m nuclei -es info -eid revoked-ssl-certificate,untrusted-root-certificate,CVE-2017-5487,CVE-2000-0114,CVE-2022-45362,mismatched-ssl-certificate,mismatched-ssl,credentials-disclosure,expired-ssl,weak-cipher-suites -o "${NNEW}" --fleet nucleinew --spinup 3 --rm-when-done --rm-logs;fi

# Append new findings to the running list and notify Discord of new findings
anew "${HOME}"/Projects/proteus_output/nuclei.running.txt  <"${NNEW}" | notify -silent -bulk -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml -mf "New Nuclei Vulns found!  {{data}}" > /dev/null

# Log complete to discord
echo "nucleinew.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
