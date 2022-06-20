#!/usr/bin/env bash

error() {
  printf "\x1b[31mError: %s\x1b[0m\n" "$1"
}

prompt() {
  read -r -p "$1: (default: '${json_conf[$1]}'): " input
  if [ -z "$input" ]; then
    json_conf[$1]="${json_conf[$1]}"
  else
    json_conf[$1]="$input"
  fi
}

yn_prompt() {
  menu=0
  while [ $menu == 0 ]; do
    read -n 1 -r -p "Enable '$1' (default: '${json_conf[$1]}') [Y/N/(D)efault]: " input
    echo "$2"
    case $input in
      [yY]) json_conf[$1]=true; menu=1;;
      [nN]) json_conf[$1]=false; menu=1;;
      [dD]) menu=1;;
      *) error "Invalid Input '$input', try again";;
    esac
  done
}

function list_prompt() {
  choices=("$@")

  local menu=0
  while [ $menu == 0 ]; do
    for (( i=1; i<${#choices[@]}; i++)); do
      echo "[$i] ${choices[$i]}"
    done
    echo ""

    read -n 1 -r -p "$1 (default: '${json_conf[$1]}') [1-$((${#choices[@]}-1))|(D)efault]: " input
    echo ""

    if [[ "$input" == 'd' || "$input" == 'D' ]]; then
      menu=1
    elif [[ "$input" -lt 1 || "$input" -gt "$((${#choices[@]}-1))"  ]]; then
      error "Invalid Input '$input', try again"
      echo ""
      sleep 0.6
    else 
      json_conf[$1]="\"${choices[$input]}\""
      menu=1
    fi
  done
}

declare -A json_conf

function default() {
  if command -v jq &> /dev/null &&  [[ -f "./profile.json" ]] ; then
    json_conf[$1]=$(jq ".$1" "profile.json")
  else
    $2
  fi
}
default "no_de" true
default "is_minimal" false
default "git_name" "Example-Name"
default "git_email" "ExampleEmail@email.com"
default "display_protocol" "Wayland"

yn_prompt "no_de" 
prompt "git_name"
prompt "git_email"
list_prompt "display_protocol" "Wayland" "X11" "Headless"

echo -n "" > profile.json
echo "{" >> profile.json
for key in "${!json_conf[@]}"; do
  val=${json_conf[$key]}
  echo "  \"$key\": $val," >> profile.json
done
echo "  \"_eof_\": null" >> profile.json
echo "}" >> profile.json

echo "Created JSON file: "
while read -r line; do
  echo -e "  \x1b[33m$line\x1b[0m"
done < profile.json
