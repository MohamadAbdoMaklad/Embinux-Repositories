#!/bin/bash

# Log file
LOG_FILE="/var/log/cli_app.log"

# Function to log actions
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Check if running in admin mode
is_admin() {
    if [ "$(id -u)" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Function to display system information using procfs
show_system_info() {
    log_action "Showing system information"
    
    echo "System Information:"
    
    # CPU info
    echo "CPU Information:"
    cpu_usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"}' <(grep 'cpu ' /proc/stat) <(sleep 1; grep 'cpu ' /proc/stat))
    echo "CPU Usage: $cpu_usage"
    
    cpu_freq=$(awk '/cpu MHz/ {print $4; exit}' /proc/cpuinfo)
    echo "CPU Frequency: $cpu_freq MHz"
    
    # RAM info
    echo "RAM Information:"
    total_ram=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    free_ram=$(awk '/MemFree/ {print $2}' /proc/meminfo)
    used_ram=$((total_ram - free_ram))
    ram_usage_percent=$(awk "BEGIN {printf \"%.2f\", $used_ram / $total_ram * 100}")
    ram_used_gb=$(awk "BEGIN {printf \"%.2f\", $used_ram / 1024 / 1024}")
    echo "RAM Usage: $ram_usage_percent%"
    echo "RAM Used: $ram_used_gb GB"
    
    # Disk info
    echo "Disk Information:"
    disk_stats=$(awk '$4=="sda" {print $3, $7}' /proc/diskstats)
    read disk_reads disk_writes <<< "$disk_stats"
    total_ops=$((disk_reads + disk_writes))
    disk_usage=$(df -h / | awk '/\// {print $5}')
    echo "Disk Usage: $disk_usage"
    
    # Note: Free space is not directly available in procfs, using df command
    disk_free=$(df -h / | awk 'NR==2 {print $4}')
    echo "Free Space: $disk_free"
}


# Function to change CPU policy (Optional)
change_cpu_policy() {
    log_action "Changing CPU policy"
    echo "Available governors:"
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
    read -p "Enter the desired governor: " governor
    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        echo $governor > $cpu/cpufreq/scaling_governor
    done
    echo "CPU policy changed to $governor"
}

# Function to set battery threshold (Optional)
set_battery_threshold() {
    log_action "Setting battery threshold"
    read -p "Enter battery threshold percentage (0-100): " threshold
    if [ -f "/sys/class/power_supply/BAT0/charge_control_end_threshold" ]; then
        echo $threshold > /sys/class/power_supply/BAT0/charge_control_end_threshold
        echo "Battery threshold set to $threshold%"
    else
        echo "Battery threshold control not available on this system"
    fi
}

# Function to control PC LEDs (Optional)
control_pc_leds() {
    log_action "Controlling PC LEDs"
    echo "1. Turn on CAPS LOCK LED"
    echo "2. Turn off CAPS LOCK LED"
    read -p "Enter your choice (1-2): " choice

    # Find the first available console
    for console in /dev/console /dev/tty{0..63}; do
        if [ -w "$console" ]; then
            break
        fi
    done

    if [ ! -w "$console" ]; then
        echo "No writable console found. Cannot control LEDs."
        return
    fi

    case $choice in
        1)
            # Turn on CAPS LOCK LED
            setleds -L +caps < "$console"
            echo "CAPS LOCK LED turned on"
            ;;
        2)
            # Turn off CAPS LOCK LED
            setleds -L -caps < "$console"
            echo "CAPS LOCK LED turned off"
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

# Function to show devices using sysfs
show_devices() {
    log_action "Showing devices"
    
    echo "Devices Information:"
    
    # CPU information
    echo "CPU Information:"
    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        cpu_num=${cpu##*/cpu}
        echo "CPU $cpu_num:"
        cat $cpu/cpufreq/scaling_cur_freq 2>/dev/null || echo "Frequency information not available"
        cat $cpu/topology/core_id 2>/dev/null || echo "Core ID information not available"
        cat $cpu/topology/physical_package_id 2>/dev/null || echo "Package ID information not available"
        echo
    done

    # PCI devices
    echo "PCI Devices:"
    for dev in /sys/bus/pci/devices/*; do
        echo "Device: $(basename $dev)"
        cat $dev/vendor 2>/dev/null || echo "Vendor information not available"
        cat $dev/device 2>/dev/null || echo "Device information not available"
        cat $dev/class 2>/dev/null || echo "Class information not available"
        echo
    done

    # USB devices
    echo "USB Devices:"
    for dev in /sys/bus/usb/devices/[0-9]-*; do
        if [ -e "$dev/product" ]; then
            echo "Device: $(basename $dev)"
            cat $dev/product 2>/dev/null
            cat $dev/manufacturer 2>/dev/null
            cat $dev/serial 2>/dev/null
            echo
        fi
    done

    # Block devices
    echo "Block Devices:"
    for dev in /sys/block/*; do
        echo "Device: $(basename $dev)"
        cat $dev/size 2>/dev/null || echo "Size information not available"
        cat $dev/removable 2>/dev/null || echo "Removable information not available"
        echo
    done

    # Network devices
    echo "Network Devices:"
    for dev in /sys/class/net/*; do
        echo "Device: $(basename $dev)"
        cat $dev/address 2>/dev/null || echo "MAC address not available"
        cat $dev/operstate 2>/dev/null || echo "Operational state not available"
        echo
    done

    if is_admin; then
        echo "Admin Options:"
        echo "1. Change CPU policy"
        echo "2. Set battery threshold"
        echo "3. Control PC LEDs"
        echo "4. Return to main menu"
        read -p "Enter your choice (1-4): " choice
        
        case $choice in
            1) change_cpu_policy ;;
            2) set_battery_threshold ;;
            3) control_pc_leds ;;
            4) return ;;
            *) echo "Invalid choice" ;;
        esac
    fi
}

# Function for directory sync (placeholder)
directory_sync() {
    log_action "Syncing directory"
    echo "Directory sync feature (not implemented)"
    # Implementation would go here
}

# Function to show network information
show_network_info() {
    log_action "Showing network information"
    
    ip_address=$(hostname -I | awk '{print $1}')
    dns_servers=$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}')
    
    echo "Network Information:"
    echo "IP Address: $ip_address"
    echo "DNS Servers: $dns_servers"
    
    echo "Network Statistics:"
    cat /proc/net/dev | awk 'NR>2 {print $1 " RX: " $2 " bytes, TX: " $10 " bytes"}'
}


# Function to reboot system
reboot_system() {
    log_action "Rebooting system"
    echo "Rebooting system..."
    reboot
}

# Function to shutdown system
shutdown_system() {
    log_action "Shutting down system"
    echo "Shutting down system..."
    shutdown -h now
}

# Function to show kernel logs
show_kernel_logs() {
    log_action "Showing kernel logs"
    cat /proc/kmsg
}

# Main menu
main_menu() {
    while true; do
        echo "Main Menu:"
        echo "1. System Information"
        echo "2. Devices"
        echo "3. Directory Sync"
        echo "4. Network Information"
        if is_admin; then
            echo "5. Reboot System"
            echo "6. Shutdown System"
            echo "7. Kernel Logs"
        fi
        echo "0. Exit"
        
        read -p "Enter your choice: " choice
        
        case $choice in
            1) show_system_info ;;
            2) show_devices ;;
            3) directory_sync ;;
            4) show_network_info ;;
            5) if is_admin; then reboot_system; else echo "Admin access required"; fi ;;
            6) if is_admin; then shutdown_system; else echo "Admin access required"; fi ;;
            7) if is_admin; then show_kernel_logs; else echo "Admin access required"; fi ;;
            0) exit 0 ;;
            *) echo "Invalid choice" ;;
        esac
        
        echo
        read -p "Press Enter to continue..."
        clear
    done
}

# Start the application
main_menu