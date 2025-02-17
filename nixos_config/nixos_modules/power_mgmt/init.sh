#!/usr/bin/env bash

# Function to set power control to 'auto' for a given device name
set_pci_power_to_auto() {
    local DEVICE_NAME=$1
    local PCI_ADDRESSES=$(lspci | grep -i "$DEVICE_NAME" | awk '{print $1}')
    
    while IFS= read -r addr; do
        # Process each line
        echo "Processing: $DEVICE_NAME@$addr"
        
        if [ -n "$addr" ]; then
            # Construct the path to the power control file
            POWER_CONTROL_PATH="/sys/bus/pci/devices/0000:$addr/power/control"

            # Apply the 'auto' power management setting
            echo 'auto' | sudo tee "$POWER_CONTROL_PATH"
        else
            echo "$DEVICE_NAME:$addr not found."
        fi
    done <<< "$PCI_ADDRESSES"
}

# Set power control to auto for the following PCI devices
set_pci_power_to_auto "Root Complex"    # AMD Phoenix Root Complex
set_pci_power_to_auto "IOMMU"           # AMD Phoenix IOMMU
set_pci_power_to_auto "FCH SMBus"       # AMD FCH SMBus Controller
set_pci_power_to_auto "Root Complex"    # AMD FCH LPC Bridge
set_pci_power_to_auto "PSP"             # AMD Phoenix CCP/PSP 3.0 Device
set_pci_power_to_auto "IPU"             # AMD IPU
set_pci_power_to_auto "Dummy"           # Set AMD Phoenix Dummy Devices (Unused PCI devices on the chipset)
set_pci_power_to_auto "Fabric"          # AMD Phoenix Data Fabric Functions
set_pci_power_to_auto "VGA compatible controller: Advanced Micro Devices"         # AMD Phoenix3 iGPU
set_pci_power_to_auto "VGA compatible controller: NVIDIA Corporation"             # dGPU
set_pci_power_to_auto "NVMe SSD" # SSD

# Set USB Controllers to auto
echo 'auto' | sudo tee /sys/bus/usb/devices/1-4/power/control
echo 'auto' | sudo tee /sys/bus/usb/devices/1-5/power/control

# Misc Tweaks
echo '500' | sudo tee /proc/sys/vm/dirty_writeback_centisecs # VM writeback timeout 
echo '1' | sudo tee /sys/module/snd_hda_intel/parameters/power_save # Intel Audio codec power management
