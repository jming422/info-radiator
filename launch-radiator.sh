#!/bin/bash

# Start with URLs to open
things=("https://pkc.io"
	"https://give.imb.org"
	"https://www.imb.org/give/projects/#give_projects_body"
"https://invis.io/TETNHZ6GMFH#/380419552_Orchard_Dashboard"
	"https://pkc.io/blog"
    "https://pkc.grafana.net/d/JNgtN9DWk/reveel-focus?orgId=1"
	"https://invis.io/APRC3XGM83J#/362225257_Home")

# Grab files from the images directory as well
shopt -s nullglob
shopt -s nocaseglob
for file in /home/pkc/info-radiator/images/*.{png,jpg,jpeg,gif,pdf}
do
    things+=("file://$file")
done
shopt -u nullglob
shopt -u nocaseglob

# Shuffle the things array
# (help from https://www.linuxquestions.org/questions/linux-general-1/randomly-shuffling-of-array-elements-837184/#post4124234)
num=$(( ${#things[@]} -1 ))
newseq=$( shuf -i 0-$num )
shuffled=()
for newi in $newseq; do
    shuffled+=("${things[$newi]}")
done

# Start the X window system automation
xdotool mousemove --screen 0 1500 400
firefox --no-remote "${shuffled[@]/#/}" &
xdotool search --sync --onlyvisible --class "Firefox" windowactivate key F11
xdotool mousemove --screen 0 0 0

while true
do
    xdotool key ctrl+Next sleep 15
done
