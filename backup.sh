#!/bin/bash

array=$(yq 'to_entries | .[] | .key' config.yaml)
echo $array

