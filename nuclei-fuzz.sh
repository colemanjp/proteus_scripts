#!/bin/bash

PATH=$PATH:"${HOME}"/.axiom/interact:"${HOME}"/go/bin

# Scan output of katana-param.sh with nuclei-fuzz
PARAMNEW="${HOME}"/Projects/proteus_output/katana/katana-param.new

# New nuclei-fuzz output
NFNEW="${HOME}"/Projects/proteus_output/nuclei-fuzz.new

# If the input file has something in it, run nuclei
if [ -s "${PARAMNEW}" ]; then axiom-scan "${PARAMNEW}" -m custom/nuclei-fuzz -o "${NFNEW}" --fleet nuclei-fuzz --spinup 3 --rm-when-done --rm-logs;fi

# Append new findings to the running list and notify Discord of new findings
anew "${HOME}"/Projects/proteus_output/nuclei-fuzz.running.txt  <"${NFNEW}" | notify -silent -bulk -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml -mf "New Nuclei Fuzz Vulns found!  {{data}}" > /dev/null

# Log complete to discord
echo "nuclei-fuzz.sh Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
