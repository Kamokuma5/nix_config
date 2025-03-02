#!/usr/bin/env bash

# dGPU will always be set to "Hybrid" during resume. 'supergfxctl -g' will still show the last set state. This script will set the dGPU to the correct state
output=$(supergfxctl -g)

# Check if the output is "Integrated"
if [ "$output" == "Integrated" ]; then
    supergfxctl -m Vfio
    supergfxctl -m Integrated
fi