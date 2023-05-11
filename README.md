# Post process proteus output

## Requires

Proteus [https://github.com/pry0cc/proteus](https://github.com/pry0cc/proteus)

Axiom [https://github.com/pry0cc/axiom](https://github.com/pry0cc/axiom)

Scripts require tmux, anew, notify, locally and assume you are running the tools, aquatone, nuclei, paramspider from axiom.

## aquatonenew.sh

Runs aquatone on the last day's new URLs found by proteus

`55 03 * * * "${HOME}"/Projects/proteus_output/scripts/wrapper.sh -c "${HOME}/Projects/proteus_output/scripts/aquatonenew.sh" -s "aquatonenew" > /dev/null`

## nucleinew.sh

Run nuclei on new URLs found by proteus

`"${HOME}"/Projects/proteus_output/scripts/wrapper.sh -c "${HOME}/Projects/proteus_output/scripts/nucleinew.sh" -s "nucleinew" > /dev/null`

## paramspider.sh

Run paramspider on new URLs found by proteus

`"${HOME}"/Projects/proteus_output/scripts/wrapper.sh -c "${HOME}/Projects/proteus_output/scripts/paramspider.sh" -s "paramspider" > /dev/null`

## wrapper.sh
axiom commands need a tty. Launch them from tmux with wrapper.sh so they work from cron

[https://colemanjp.github.io/posts/tmux_cron/](https://colemanjp.github.io/posts/tmux_cron/)

## notifyteams.sh

Send a single target's recent output to Teams.  The main scripts use Discord.

`${HOME}/Projects/proteus_output/scripts/notifyteams.sh -t example`
