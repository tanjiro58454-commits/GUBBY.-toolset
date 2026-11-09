#!/bin/bash

# Color codes for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display the blocks/ASCII banner
show_banner() {
    clear
    echo -e "${BLUE}"
    echo "██████╗ ██╗   ██╗██████╗ ██████╗ ██╗   ██╗    ████████╗ ██████╗  ██████╗ ██╗"
    echo "██╔════╝ ██║   ██║██╔══██╗██╔══██╗╚██╗ ██╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║"
    echo "██║  ███╗██║   ██║██████╔╝██████╔╝ ╚████╔╝        ██║   ██║   ██║██║   ██║██║"
    echo "██║   ██║██║   ██║██╔══██╗██╔══██╗  ╚██╔╝         ██║   ██║   ██║██║   ██║██║"
    echo "╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║          ██║   ╚██████╔╝╚██████╔╝███████╗"
    echo " ╚═════╝  ╚═════╝ ╚══════╝╚══════╝    ╚═╝          ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝"
    echo -e "${YELLOW}                      Created for gubby.tool.Set GUI${NC}"
    echo "--------------------------------------------------------------------------------"
}

# Function to handle exit
exit_script() {
    echo -e "\n${RED}Exiting gubby.tool. Bye!${NC}"
    exit 0
}

# First Option Screen
show_banner
echo -e "${YELLOW}[+] Welcome to gubby.tool.Set${NC}"
echo -e "Choose an option:"
echo -e "${GREEN}[c] Continue${NC}"
echo -e "${RED}[e] Exit${NC}"
read -p "Enter your choice (c/e): " choice1

if [[ "$choice1" != "c" && "$choice1" != "C" ]]; then
    exit_script
fi

# Second Option Screen (Confirmation)
show_banner
echo -e "${RED}[!] Double Check / Confirmation${NC}"
echo -e "Are you sure you want to proceed with the installation?"
echo -e "${GREEN}[c] Continue and Install${NC}"
echo -e "${RED}[e] Exit${NC}"
read -p "Confirm your choice (c/e): " choice2

if [[ "$choice2" != "c" && "$choice2" != "C" ]]; then
    exit_script
fi

# Starting System Update (Termux friendly - No sudo)
show_banner
echo -e "${YELLOW}[*] Running apt update && apt upgrade -y...${NC}"
apt update && apt upgrade -y

# Array of corrected tool package names for APT
tools=(
    "netcat-traditional" "socat" "tcpdump" "wireshark" "iptables" 
    "sqlmap" "metasploit-framework" "nmap" "traceroute" "mtr" 
    "fping" "netdiscover" "whois" "dnsrecon" "amass" 
    "whatweb" "theharvester" "hydra" "hashcat" "john" 
    "sqlite3" "postgresql-client" "mariadb-client" "redis-tools" "sleuthkit" 
    "testdisk" "photorec" "foremost" "exiftool" "tor" 
    "torsocks" "proxychains4" "openvpn" "wireguard" "mat2" 
    "htop" "tmux" "rsync" "lsof" "ncdu" 
    "tree" "psmisc" "sysstat" "jadx" "apktool" 
    "gdb" "radare2" "binutils" "strings" "file" 
    "git" "wget" "curl" "aria2" "unzip" 
    "zip" "p7zip-full" "tar" "xz-utils" "zstd" 
    "ca-certificates" "gnupg" "jq"
)

total_tools=${#tools[@]}
current=1

echo -e "\n${YELLOW}[*] Starting one-by-one tool installation...${NC}\n"

# Installing tools one by one without sudo
for tool in "${tools[@]}"; do
    echo -e "${BLUE}[$current/$total_tools] Installing: ${YELLOW}$tool${NC}"
    
    # Check if package exists in repository to avoid abrupt failures
    if apt-cache show "$tool" > /dev/null 2>&1; then
        apt install -y "$tool"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}[+] Successfully installed: $tool${NC}\n"
        else
            echo -e "${RED}[-] Failed to install: $tool${NC}\n"
        fi
    else
        echo -e "${RED}[-] Tool '$tool' not found in repository. Skipping...${NC}\n"
    fi
    
    current=$((current + 1))
done

echo -e "${GREEN}[███] All operations completed successfully!${NC}"

