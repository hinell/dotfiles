#!/usr/bin/bash
# File........: spinner.sh
# Summary.....: Fancy animation for shell! 
# Created-at..: March 29, 2025 
# Authors.....: Alex A. Davronov <al.neodim@gmail.com> (2025-)
# Repository..: N/A
# Description.: This script simply displays fancy animation! 
# Usage.......: chmod +x spinner.sh && ./$_ 

A=( "⠧" "⠏" "⠛" "⠹"  "⠼"  "⠶" )
B=(
		'[.        ]'
		'[...      ]'
		'[ ...     ]'
		'[  ...    ]'
		'[   ...   ]'
		'[    ...  ]'
		'[     ... ]'
		'[      ...]'
		'[       ..]'
		'[        .]'
		'[        .]'
		'[       ..]'
		'[      ...]'
		'[     ... ]'
		'[    ...  ]'
		'[   ...   ]'
		'[  ...    ]'
		'[ ...     ]'
		'[...      ]'
		'[..       ]'
'[.        ]'
)
B_size=${#B[@]}
A_size=${#A[@]}

trap 'exit 1' TERM KILL INT
trap 'tput cvvis' EXIT 

bind -r '\C-M'

i=0
while [ true ]
do
	sleep 0.1s
	idx=$((i % A_size))
	idx2=$((i % B_size))


	tput civis # make cursor invisible
	echo -e -n "in progress $(tput cub 1)${A[$idx]} ${B[$idx2]} \r"
	# The same can be achieved by using tput:
	# tput cuu1;
	# echo -e "in progress $(tput cub 1) ${A[$idx]} ${B[$idx2]} \r"
	i=$(( i + 1  ))
done
