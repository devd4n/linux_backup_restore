#!/bin/bash

backup_destination=$(yq -r '.backup_destination' config.yml)
backup_tmp=$(yq -r '.backup_tmp' config.yml)
backup_naming=$(yq -r '.backup_naming' config.yml)
backup_temp="${backup_destination}temp/"

echo "backup_destination=$backup_destination"
echo "backup_temp=$backup_tmp"
echo "backup_naming=$backup_naming"

function backup_dirs {
  # extract indices the backup_file array stores to an array (0 1 2 ...)
  keyindizes=($(yq -r '.backup_files | to_entries| .[] | .key ' config.yml))

  # go through each index and do stuff with source and destination path
  for index in ${!keyindizes[@]}; do
    src=$(yq -r ".backup_files[$index].src" config.yml)
    dst=$(yq -r ".backup_files[$index].dst" config.yml)
    dst="$backup_temp$dst"
    echo "backup::: src=$src > dst=$dst"
    rsync -a -rvv --delete $src $dst
  done
}

function backup_files {
  #TODO: Copy from backup_dirs add it to config.yml
}

function backup_dbs {
  # TODO: Make it work - use sqldump... etc.
  # extract indices the backup_file array stores to an array (0 1 2 ...)
  keyindizes=($(yq '.backup_files | to_entries| .[] | .key ' config.yml))

  for index in ${!keyindizes[@]}; do
    db_name=$(yq ".backup_files[$index].db_name" config.yml)
    db_user=$(yq ".backup_files[$index].db_name" config.yml)
    db_password=$(yq ".backup_files[$index].db_name" config.yml)
    dst=$(yq ".backup_files[$index].dst" config.yml)
  done
}


backup_dirs

