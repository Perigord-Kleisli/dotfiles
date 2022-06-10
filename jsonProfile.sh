#!/bin/env bash

error() {
  printf "\x1b[31mError: %s\x1b[0m\n" "$1"
}

prompt() {
  read -r -p "$1: (default: '${json_conf[$1]}'): " input
  json_conf[$1]="\"$input\""
}

yn_prompt() {
  menu=0
  while [ $menu == 0 ]; do
    read -n 1 -r -p "Enable '$1' (default: '${json_conf[$1]}') [Y/N/(D)efault]: " input
    echo ""
    case $input in
      [yY]) json_conf[$1]=true; menu=1;;
      [nN]) json_conf[$1]=false; menu=1;;
      [dD]) menu=1;;
      *) error "Invalid Input '$input', try again";;
    esac
  done
}

declare -A json_conf
if uname -a | grep -qi nixos; 
  then json_conf[on_nixos]=true
  else json_conf[on_nixos]=false
fi
json_conf[is_minimal]=true
json_conf[git_name]="Example-Name"
json_conf[git_email]="ExampleName@email.com"

yn_prompt "on_nixos"
yn_prompt "is_minimal"
prompt "git_name"
prompt "git_email"

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
