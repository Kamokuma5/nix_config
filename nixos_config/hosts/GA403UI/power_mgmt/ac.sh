echo '500' | sudo tee /proc/sys/vm/dirty_writeback_centisecs # VM writeback timeout 
echo '0' | sudo tee /sys/module/snd_hda_intel/parameters/power_save # Audio codec power management

MON="eDP-1"
RES="2880x1800"
FREQ="120.00Hz"

for dir in /run/user/*; do
  for hypr_dir in "$dir/hypr/"*/; do
    socket="${hypr_dir}.socket.sock"
    if [[ -S $socket ]]; then 
      echo -e "keyword monitor $MON,$RES@$FREQ,auto,1.6" | socat - UNIX-CONNECT:"$socket"
    fi
  done
done
