#!/bin/bash
#sanke game in B.E.M
#by Araújo, Wasley de G.
#version 2.0

_0="$(<$0)"

#conf control
declare -A c=( [a]=-1 [s]=30 [d]=1 [w]=-30 )

#make template display
n=0
declare -a "T["{0..599}"]=$((n++ % 30 == 29 ? 2 : n % 30 == 1 ? 1 : n < 29 ? 1 : n > 570 ? 1 : 0 ))"
T=( ${T[@]//2/1\\n} )
T=( ${T[@]//1/#} )

#set snake vect
s=( 97 98 99 )

#make recursive function
. /dev/stdin <<< "_f(){ ${_0//*::lp_i}; }"
: ::lp_i

#take input
read -st0.1 -n1 i

#load template display
t=( "${T[@]//0/ }" )

#calc head postion and next step
h=$((s[-1]+(${c[${i:-z}]:- s[-1]-s[-2]}==s[-2]-s[-1] ? s[-1]-s[-2] : ${c[${i:-z}]:- s[-1]-s[-2]})))

#check take food
F=${f/$h}
${F:+:} unset f 
: ${f:=$((x=(RANDOM%539+30), x % 30 == 29 ? x-=3 : x % 30 == 0 ? x+=3 : x))}
t[$f]=%

#check colition in body
declare -a "S[${s["{0..200}"]:-${s[$((j=0))]}}]=$((j++))"
${S[$h]:+ exit 0}

#move snak
s=( ${s[@]:0${F:+1}} $h )

#check colition in board
B=${t[$h]//[^#]}
${B:+ exit 0}

#draw snak in display buffer
. /dev/stdin <<< $(echo "t[${s["{0..200}"]:-${s[-1]}}]=@")

#draw buffer display
clear
echo -e "${t[@]}\n\n\t\t\t\tPOINT: $((${#s[@]}-3))"

#quit game
i=${i//[^q]}
${i:+ exit 0}
_f
