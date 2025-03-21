#!/usr/bin/env bash

wpctl set-mute @DEFAULT_SOURCE@ toggle

default_source_line=$(wpctl status | awk '/Sources/{flag=1} flag && /\*/ {print; exit}')

if echo "$default_source_line" | grep -q "MUTED"; then
    pw-play --volume=1 "/home/bear/nix_config/hm_config/mic_mute/discord-mute.wav"
else
    pw-play --volume=1 "/home/bear/nix_config/hm_config/mic_mute/discord-unmute.wav"
fi
