echo '1500' | sudo tee /proc/sys/vm/dirty_writeback_centisecs # VM writeback timeout 
echo '1' | sudo tee /sys/module/snd_hda_intel/parameters/power_save # Audio codec power management