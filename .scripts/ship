#!/usr/bin/env bash
## Title........: ship.sh
## Description..: A simple, handy network addressing multitool with plenty of features.
## Author.......: Sotirios M. Roussis a.k.a. xtonousou - xtonousou@gmail.com
## Date.........: 20170722
## Usage........: bash ship.sh [options]? [arguments]?
## Bash Version.: 3.2 or later

### Debugging
#set -o xtrace

### Script's Info
readonly VERSION="2.6.1"
readonly SCRIPT_NAME="ship"

### Author's Info
readonly AUTHOR="Sotirios M. Roussis"
readonly AUTHOR_NICKNAME="xtonousou"
readonly GMAIL="${AUTHOR_NICKNAME}@gmail.com"
readonly GITHUB="https://github.com/${AUTHOR_NICKNAME}"

### Colors
declare -r COLORS=(
  "\e[1;0m"     # Normal  ## COLORS[0]
  "\033[1;31m"  # Red     ## COLORS[1]
  "\033[1;32m"  # Green   ## COLORS[2]
  "\033[1;33m"  # Orange  ## COLORS[3]
  "\033[1;36m"  # Cyan    ## COLORS[4]
  "\033[1;95m"  # Magenta ## COLORS[5]
)

### Locations
readonly TEMP="/tmp"
readonly GOOGLE_DNS="8.8.8.8"
declare -r PUBLIC_IP=(
  "icanhazip.com"
  "ident.me"
  "ipinfo.io/ip"
  "wgetip.com"
  "wtfismyip.com/text"
)

### Timeouts
readonly SHORT_TIMEOUT="2"
readonly TIMEOUT="6"
readonly LONG_TIMEOUT="17"

### Dialogs
readonly DIALOG_UNDER_DEVELOPMENT="${COLORS[1]}under development${COLORS[0]}"
readonly DIALOG_PRESS_CTRL_C="Press [CTRL+C] to stop"
readonly DIALOG_ERROR="Try ${SCRIPT_NAME} ${COLORS[2]}-h${COLORS[0]} or ${SCRIPT_NAME} ${COLORS[2]}--help${COLORS[0]} for more information."
readonly DIALOG_ABORTING="${COLORS[1]}Aborting${COLORS[0]}."
readonly DIALOG_NO_ARGUMENTS="No arguments. ${DIALOG_ABORTING}"
readonly DIALOG_NO_INTERNET="Internet connection unavailable. ${DIALOG_ABORTING}"
readonly DIALOG_IPV6_UNAVAILABLE="IPv6 unavailable. ${DIALOG_ABORTING}"
readonly DIALOG_NO_LOCAL_CONNECTION="Local connection unavailable. ${DIALOG_ABORTING}"
readonly DIALOG_DESTINATION_UNREACHABLE="Destination is unreachable. ${DIALOG_ABORTING}"
readonly DIALOG_SERVER_IS_DOWN="Destination is unreachable. Server may be down or has connection issues. ${DIALOG_ABORTING}"
readonly DIALOG_NO_VALID_IPV4="The IPv4 address is invalid. ${DIALOG_ABORTING}"
readonly DIALOG_NO_VALID_IPV6="The IPv6 address is invalid. ${DIALOG_ABORTING}"
readonly DIALOG_NO_VALID_MASK="The netmask is invalid. ${DIALOG_ABORTING}"
readonly DIALOG_NO_VALID_CIDR="The CIDR is invalid. ${DIALOG_ABORTING}"
readonly DIALOG_NO_VALID_ADDRESSES="No valid IPv4, IPv6 or MAC addresses found. ${DIALOG_ABORTING}"
readonly DIALOG_NO_NETMASK="Netmask is missing. Usage: ${COLORS[5]}192.168.0.1/24${COLORS[0]} or ${COLORS[5]}192.168.0.1 255.255.128.0 ${DIALOG_ABORTING}"
readonly DIALOG_NO_TRACEPATH6="${COLORS[3]}tracepath6${COLORS[0]} is missing, will use ${COLORS[3]}tracepath${COLORS[0]} with no IPv6 compatibility"
readonly DIALOG_NO_TRACE_COMMAND="You must install at least one of the following tools to perform this action: ${COLORS[3]}tracepath${COLORS[0]}, ${COLORS[3]}traceroute${COLORS[0]}, ${COLORS[3]}mtr${COLORS[0]}. ${DIALOG_ABORTING}"

########################################################################
#                                                                      #
#  Helpful functions to print or check, verify and test various things #
#                                                                      #
########################################################################

# Initializes a set of regexps variables (IPv4, IPv6, with and without CIDR).
function init_regexes() {

  # MAC
  REGEX_MAC="([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}"
  # IPv4
  REGEX_IPV4="((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|"
  REGEX_IPV4+="(2[0-4]|1{0,1}[0-9]){0,1}[0-9])"
  # IPv4 with CIDR notation
  REGEX_IPV4_CIDR="(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|"
  REGEX_IPV4_CIDR+="25[0-5])\.){3}([0-9]|""[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|"
  REGEX_IPV4_CIDR+="25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))"
  # IPv6
  REGEX_IPV6="([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|"
  REGEX_IPV6+="([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:"
  REGEX_IPV6+="[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4})"
  REGEX_IPV6+="{1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|"
  REGEX_IPV6+="([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]"
  REGEX_IPV6+="{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:"
  REGEX_IPV6+="[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|"
  REGEX_IPV6+="fe08:(:[0-9a-fA-F]{1,4}){2,2}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4})"
  REGEX_IPV6+="{0,1}:){0,1}${REGEX_IPV4}|([0-9a-fA-F]{1,4}:){1,4}:${REGEX_IPV4}"
  # IPv6 with CIDR notation
  REGEX_IPV6_CIDR="^s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|"
  REGEX_IPV6_CIDR+="(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|"
  REGEX_IPV6_CIDR+="2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3})|"
  REGEX_IPV6_CIDR+=":))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|"
  REGEX_IPV6_CIDR+=":((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|"
  REGEX_IPV6_CIDR+="[1-9]?d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]"
  REGEX_IPV6_CIDR+="{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]d|1dd|"
  REGEX_IPV6_CIDR+="[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|"
  REGEX_IPV6_CIDR+="(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|"
  REGEX_IPV6_CIDR+="((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)"
  REGEX_IPV6_CIDR+="(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|(([0-9A-Fa-f]"
  REGEX_IPV6_CIDR+="{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4})"
  REGEX_IPV6_CIDR+="{0,3}:((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|"
  REGEX_IPV6_CIDR+="[1-9]?d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]"
  REGEX_IPV6_CIDR+="{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]d|"
  REGEX_IPV6_CIDR+="1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|[1-9]?d)){3}))|:))|"
  REGEX_IPV6_CIDR+="(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}"
  REGEX_IPV6_CIDR+=":((25[0-5]|2[0-4]d|1dd|[1-9]?d)(.(25[0-5]|2[0-4]d|1dd|"
  REGEX_IPV6_CIDR+="[1-9]?d)){3}))|:)))(%.+)?s*(\/([0-9]|[1-9][0-9]|"
  REGEX_IPV6_CIDR+="1[0-1][0-9]|12[0-8]))?$"

  return 0
}

# Convert a decimal to binary.
function dec_to_bin() {

  declare D2B

  D2B=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})

  echo -n "${D2B[${1}]}"

  return 0
}

# Convert a decimal to a hexadecimal.
function dec_to_hex() {

  printf "%#X" "${1}"

  return 0
}

# Convert binary to a decimal.
function bin_to_dec() {

  echo "$((2#${1}))"

  return 0
}

# Returns the integer representation of an IP arg,
# passed in ascii dotted-decimal notation (x.x.x.x).
function dotted_quad_ip_to_decimal {

  local IFS A B C D IP="${1}"

  IFS=. read -r A B C D <<< "${IP}"
  
  printf '%d\n' "$(( A * 256 ** 3 + B * 256 ** 2 + C * 256 + D ))"

  return 0
}

# Prints a message while checking a network host.
function print_check() {

  echo -ne "Checking ${COLORS[2]}${1}${COLORS[0]} ..."

  return 0
}

# Clears previous line.
function clear_line() {

  printf "\r\033[K"

  return 0
}

# Prints a list of most common ports with protocols.
function print_port_protocol_list() {

  local ITEM

  declare -r PORTS_ARRAY=(
    "20-21" "22" "23" "25" "53" "67-68" "69" "80" "110" "123" "137-139" "143"
    "161-162" "179" "389" "443" "636" "989-990"
  )

  declare -r PORTS_TCP_UDP_ARRAY=(
    "TCP" "TCP" "TCP" "TCP" "TCP/UDP" "UDP" "UDP" "TCP" "TCP" "UDP" "TCP/UDP"
    "TCP" "TCP/UDP" "TCP" "TCP/UDP" "TCP" "TCP/UDP" "TCP"
  )

  declare -r PORTS_PROTOCOL_ARRAY=(
    "FTP" "SSH" "Telnet" "SMTP" "DNS" "DHCP" "TFTP" "HTTP" "POPv3" "NTP"
    "NetBIOS" "IMAP" "SNMP" "BGP" "LDAP" "HTTPS" "LDAPS" "FTP over TLS/SSL"
  )

  for ITEM in "${!PORTS_ARRAY[@]}"; do
    printf "%-17s%-8s%s\n" "${PORTS_PROTOCOL_ARRAY[ITEM]}" "${PORTS_TCP_UDP_ARRAY[ITEM]}" "${PORTS_ARRAY[ITEM]}"
  done

  return 0
}

# Checks network connection (local or internet).
function check_connectivity() {

  case "${1}" in
    "--local")
      ip route | grep ^default &>/dev/null \
        || error_exit "${DIALOG_NO_LOCAL_CONNECTION}"
      ;;
    "--internet")
      ping -q -c 1 -W "${LONG_TIMEOUT}" "${GOOGLE_DNS}" &>/dev/null \
        || error_exit "${DIALOG_NO_INTERNET}"
      ;;
  esac

  return 0
}

# Exits ship, if ping fails to reach $1 in an amount of time.
function check_destination() {

  local CLEAN_DESTINATION RETURNED_VALUE

  CLEAN_DESTINATION=$(echo "${1}" | sed 's/^http\(\|s\):\/\///g' | cut --fields=1 --delimiter="/")

  timeout "${LONG_TIMEOUT}" ping -q -c 1 "${CLEAN_DESTINATION}" &>/dev/null || RETURNED_VALUE="${?}"

  [[ "${RETURNED_VALUE}" -ge 2 ]] && error_exit "${DIALOG_DESTINATION_UNREACHABLE}"

  return 0
}

# Checks if a network address is valid.
function check_dotted_quad_address() {

  local IFS
  local DECIMAL_POINTS
  local PART_A PART_B PART_C PART_D

  DECIMAL_POINTS=$(echo "${1}" | grep --only-matching "\\." | wc --lines)
  # check if there are three dots
  [ "${DECIMAL_POINTS}" -ne 3 ] && show_usage_ipcalc && error_exit

  IFS=.
  read -r PART_A PART_B PART_C PART_D <<< "${1}"

  # check for non numerical values
  [[ ! "${PART_A}" =~ ^[0-9]+$ || ! "${PART_B}" =~ ^[0-9]+$ || ! "${PART_C}" =~ ^[0-9]+$ || ! "${PART_D}" =~ ^[0-9]+$ ]] \
    && show_usage_ipcalc \
    && error_exit

  # check if any part is empty
  [[ ! "${PART_A}" || ! "${PART_B}" || ! "${PART_C}" || ! "${PART_D}" ]] \
    && show_usage_ipcalc \
    && error_exit

  # check if any part of the address is < 0 or > 255
  [[ "${PART_A}" -lt 0 || "${PART_A}" -gt 255 || "${PART_B}" -lt 0 || "${PART_B}" -gt 255 || "${PART_C}" -lt 0 || "${PART_C}" -gt 255 || "${PART_D}" -lt 0 || "${PART_D}" -gt 255 ]] \
    && show_usage_ipcalc \
    && error_exit

  IFS=

  return 0
}

# Checks if IPv6 is available, if not exit.
function check_ipv6() {

  grep -i "ipv6" "/proc/modules" &> /dev/null \
    || echo "IPv6 is supported but the 'ipv6' module is not loaded"
  
  test -f "/proc/net/if_inet6" || error_exit "${DIALOG_IPV6_UNAVAILABLE}"

  return 0
}

# Checks if an argument is passed, if not exit.
# $1=error message, $2=argument
function check_for_missing_args() {

  [ -z "${2}" ] && error_exit "${1}"

  return 0
}

# Numerical verification.
function check_if_parameter_is_positive_integer() {

  [[ ! "${1}" =~ ^[0-9]+$ ]] && error_exit "${1} is not a positive integer. ${DIALOG_ABORTING}" "${1}"

  return 0
}

# Checks for root privileges.
function check_root_permissions() {

  [ "$(id -u)" -ne 0 ] && error_exit "${COLORS[2]}${SCRIPT_NAME}${COLORS[0]} requires ${COLORS[1]}root${COLORS[0]} privileges for this action."

  return 0
}

# Checks Bash version. Minimum is version 3.2.
function check_bash_version() {

  [ "${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}" -lt 32 ] && error_exit "Insufficient Bash version. Bash 3.2 or newer is required. ${DIALOG_ABORTING}"

  return 0
}

# Deletes every file that is created by this script. Usually in /tmp.
function mr_proper() {

  # "${TEMP:?}" to ensure this never expands to /*
  rm --recursive --force "${TEMP:?}/${SCRIPT_NAME}"* &>/dev/null

  return 0
}

# Background tasks' handler.
function handle_jobs() {

  local JOB

  for JOB in $(jobs -p); do wait "${JOB}"; done

  return 0
}

# Used with zero parameters: exit 1.
# Used with one parameter  : echoes parameter, usually error dialogs.
# Used with two parameters : invalid option, then echoes first parameter, usually error dialogs.
function error_exit() {

  [ -z "${1}" ] && clear_line && exit 1 \
    || [ -z "${2}" ] \
      && clear_line \
      && echo -e "${1}" \
      && exit 1 \
    || clear_line\
      && echo -e "${SCRIPT_NAME}: invalid option '${2}'" \
      && echo -e "${1}" && \
      exit 1
}

# Traps INT and SIGTSTP.
function trap_handler() {

  local YESNO=""
  
  echo
  while [[ ! "${YESNO}" =~ ^[YyNn]$ ]]; do
    echo -ne "Exit? [y/n] "
    read -r YESNO &>/dev/null
  done

  [ "${YESNO}" = "N" ] && YESNO="n"
  [ "${YESNO}" = "Y" ] && YESNO="y"
  [ "${YESNO}" = "y" ] && handle_jobs && exit 0

  return 0
}

########################################################################
#                                                                      #
#  Main script's functions in alphabetical order based on show_usage() #
#                                                                      #
########################################################################

# Prints active network interfaces with their IPv4 address.
function show_ipv4() {

  local ITEM

  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV4_ARRAY

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV4_ARRAY[ITEM]=$(ip -4 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family=inet '$0 ~ family {print $2}' | cut --delimiter="/" --fields=1)
    echo "${INTERFACES_ARRAY[ITEM]}" "${IPV4_ARRAY[ITEM]}"
  done

  return 0
}

# Prints active network interfaces with their IPv6 address.
function show_ipv6() {

  check_ipv6

  local ITEM

  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV6_ARRAY

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV6_ARRAY[ITEM]=$(ip -6 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family="inet6" 'tolower($0) ~ family {print $2}' | cut --delimiter="/" --fields=1)
    echo "${INTERFACES_ARRAY[ITEM]}" "${IPV6_ARRAY[ITEM]}"
  done

  return 0
}

# Prints all "basic" info.
function show_all() {

  check_ipv6

  local MAC_OF
  local DRIVER_OF
  local GATEWAY
  local ITEM

  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV4_ARRAY
  declare IPV6_ARRAY

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV4_ARRAY[ITEM]=$(ip -4 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family=inet '$0 ~ family {print $2}' | cut --delimiter="/" --fields=1)
    IPV6_ARRAY[ITEM]=$(ip -6 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family="inet6" 'tolower($0) ~ family {print $2}' | cut --delimiter="/" --fields=1)
    [ -f "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent" ] \
      && DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent") \
      || DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/device/uevent")
    MAC_OF=$(awk '{print $0}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/address" 2> /dev/null)
    GATEWAY=$(ip route | awk "/${INTERFACES_ARRAY[ITEM]}/ && tolower(\$0) ~ /default/ {print \$3}")
    echo "${INTERFACES_ARRAY[ITEM]}" "${DRIVER_OF}" "${MAC_OF}" "${GATEWAY}" "${IPV4_ARRAY[ITEM]}" "${IPV6_ARRAY[ITEM]}"
  done

  return 0
}

# Prints all available network interfaces.
function show_all_interfaces() {

  ip link show | \
    awk '/^[0-9]/{printf "%s ", $2}' | \
      sed 's/://g' | \
        sed 's/ *$//g'
  echo
}

# Prints the driver used of active interface.
function show_driver() {
  
  local DRIVER_OF
  local ITEM

  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    [ -f "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent" ] \
      && DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent") \
      || DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/device/uevent")
    echo "${INTERFACES_ARRAY[ITEM]}" "${DRIVER_OF}" 
  done

  return 0
}

# Prints the external IP address/es. If $1 is empty prints user's public IP, if not, $1 should be like example.com.
function show_ip_from() {

  local HTTP_CODE
  local TEMP_FILE
  local RANDOM_SOURCE
  local ITEM

  RANDOM_SOURCE="${PUBLIC_IP["$(( RANDOM % ${#PUBLIC_IP[@]} ))"]}"

  if [ -z "${1}" ]; then
    print_check "${RANDOM_SOURCE}"
    HTTP_CODE=$(wget --spider --tries=1 --timeout="${TIMEOUT}" --server-response "${RANDOM_SOURCE}" 2>&1 | awk '/HTTP\//{print $2}' | tail --lines=1)

    [ ! "${HTTP_CODE}" = "200" ] && error_exit "${DIALOG_SERVER_IS_DOWN}"

    clear_line
    TEMP_FILE=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)

    echo -ne "Grabbing ${COLORS[2]}IP${COLORS[0]} ..."
    wget "${RANDOM_SOURCE}" --quiet --output-document="${TEMP_FILE}"

    # Ensure that TEMP_FILE is written on /tmp
    while [ ! -f "${TEMP_FILE}" ]; do
      wget "${RANDOM_SOURCE}" --quiet --output-document="${TEMP_FILE}"
    done

    clear_line
    awk '{print $0}' "${TEMP_FILE}"
  else
    print_check "${1}"
    check_destination "${1}"

    clear_line
    TEMP_FILE=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
    
    INPUT=$(echo "${1}" | sed --expression='s/^http\(\|s\):\/\///g' --expression='s/^`//' --expression='s/`//' --expression='s/`$//' | cut --fields=1 --delimiter="/")

    function ping_source() {
      
      for ITEM in {1..25}; do
        ping -c 1 -w "${LONG_TIMEOUT}" "${INPUT}" 2> /dev/null | awk -F '[()]' '/PING/{print $2}' >> "${TEMP_FILE}" &
      done
      handle_jobs
    }

    echo -ne "Pinging ${COLORS[2]}$1${COLORS[0]} ..."
    ping_source
    
    # Ensure that TEMP_FILE is written on /tmp
    while [ ! -f "${TEMP_FILE}" ]; do
      ping_source
    done

    clear_line
    sort --version-sort --unique "${TEMP_FILE}"
  fi

  return 0
}

# Prints all valid IPv4, IPv6 and MAC addresses extracted from file.
function show_ips_from_file() {

  local FILE
    
  [ -z "${1}" ] && error_exit "No file was specified. ${DIALOG_ABORTING}"
  for FILE in "${@}"; do
    [ ! -f "${FILE}" ] && error_exit "${COLORS[3]}${FILE}${COLORS[0]} does not exist. ${DIALOG_ABORTING}"
  done
    
  local TEMP_FILE_IPV4 TEMP_FILE_IPV6 TEMP_FILE_MAC
  local IS_TEMP_FILE_IPV4_EMPTY IS_TEMP_FILE_IPV6_EMPTY IS_TEMP_FILE_MAC_EMPTY

  TEMP_FILE_IPV4=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
  TEMP_FILE_IPV6=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
  TEMP_FILE_MAC=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)

  init_regexes

  for FILE in "${@}"; do
    grep --extended-regexp --only-matching "${REGEX_IPV4}" "${FILE}" 2>/dev/null >> "${TEMP_FILE_IPV4}"
    grep --extended-regexp --only-matching "${REGEX_IPV6}" "${FILE}" 2>/dev/null >> "${TEMP_FILE_IPV6}"
    grep --extended-regexp --only-matching "${REGEX_MAC}" "${FILE}" 2>/dev/null >> "${TEMP_FILE_MAC}"
  done

  sort --version-sort --unique --output="${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV4}"
  sort --version-sort --unique --output="${TEMP_FILE_IPV6}" "${TEMP_FILE_IPV6}"
  sort --version-sort --unique --output="${TEMP_FILE_MAC}" "${TEMP_FILE_MAC}"

  [ -s "${TEMP_FILE_IPV4}" ] && IS_TEMP_FILE_IPV4_EMPTY=0 || IS_TEMP_FILE_IPV4_EMPTY=1
  [ -s "${TEMP_FILE_IPV6}" ] && IS_TEMP_FILE_IPV6_EMPTY=0 || IS_TEMP_FILE_IPV6_EMPTY=1
  [ -s "${TEMP_FILE_MAC}" ] && IS_TEMP_FILE_MAC_EMPTY=0 || IS_TEMP_FILE_MAC_EMPTY=1

  case "${IS_TEMP_FILE_IPV4_EMPTY}:${IS_TEMP_FILE_IPV6_EMPTY}:${IS_TEMP_FILE_MAC_EMPTY}" in
    0:0:0) # IPv4, IPv6 and MAC addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV6}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-15s │ %-39s │ %s\n", $1, tolower($2), tolower($3))}'
      ;;
    0:0:1) # Only IPv4 and IPv6 addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV6}" | \
        awk -F '\t' '{printf("%-15s │ %s\n", $1, tolower($2))}'
      ;;
    0:1:0) # Only IPv4 and MAC addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-15s │ %s\n", $1, tolower($2))}'
      ;;
    0:1:1) # Only IPv4 addresses
      paste "${TEMP_FILE_IPV4}" | \
        awk -F '\t' '{printf("%s\n", $1)}'
      ;;
    1:0:0) # Only IPv6 and MAC addresses
      paste "${TEMP_FILE_IPV6}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-39s │ %s\n", tolower($1), tolower($2))}'
      ;;
    1:0:1) # Only IPv6 addresses
      paste "${TEMP_FILE_IPV6}" | \
        awk -F '\t' '{printf("%s\n", tolower($1))}'
      ;;
    1:1:0) # Only MAC addresses
      paste "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%s\n", tolower($1))}'
      ;;
    1:1:1) # None
      error_exit "${DIALOG_NO_VALID_ADDRESSES}"
      ;;
  esac

  return 0
}

# Prints active network interfaces and their gateway.
function show_gateway() {
  
  local GATEWAY ITEM
  
  declare -r INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    GATEWAY=$(ip route | awk "/${INTERFACES_ARRAY[ITEM]}/ && tolower(\$0) ~ /default/ {print \$3}")
    echo "${INTERFACES_ARRAY[ITEM]}" "${GATEWAY}"
  done

  return 0
}

# Scans live hosts on network and prints their IPv4 address with or without MAC address. ICMP and ARP.
function show_live_hosts() {
  
  check_root_permissions
  
  local ONLINE_INTERFACE NETWORK_IP NETWORK_IP_CIDR FILTERED_IP HOST
  
  ONLINE_INTERFACE=$(ip route get "${GOOGLE_DNS}" | awk -F 'dev ' 'NR == 1 {split($2, a, " "); print a[1]}')
  NETWORK_IP=$(ip route | awk "/${ONLINE_INTERFACE}/ && /src/ {print \$1}" | cut --fields=1 --delimiter="/")
  NETWORK_IP_CIDR=$(ip route | awk "/${ONLINE_INTERFACE}/ && /src/ {print \$1}")
  FILTERED_IP=$(echo "${NETWORK_IP}" | awk 'BEGIN{FS=OFS="."} NF--')
  
  ip -statistics neighbour flush all &>/dev/null
  
  echo -ne "Pinging ${COLORS[2]}${NETWORK_IP_CIDR}${COLORS[0]}, please wait ..."
  for HOST in {1..254}; do
    ping "${FILTERED_IP}.${HOST}" -c 1 -w "${LONG_TIMEOUT}" &>/dev/null &
  done
  handle_jobs
  
  clear_line
  init_regexes
  
  case "${1}" in
    "--normal")
      ip neighbour | \
        awk 'tolower($0) ~ /reachable|stale|delay|probe/{print $1}' | \
          sort --version-sort --unique
      ;;
    "--mac")      
      ip neighbour | \
        awk 'tolower($0) ~ /reachable|stale|delay|probe/{printf ("%5s\t%s\n", $1, $5)}' | \
          sort --version-sort --unique
      ;;
  esac

  return 0
}

# Prints active network interfaces.
function show_interfaces() {

  declare -r INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))

  echo "${INTERFACES_ARRAY[@]}"

  return 0
}

# Prints a list of private and reserved IPs. $1 "normal" or "cidr".
function show_bogon_ips() {

  local IP

  declare -r IPV4_BOGON_ARRAY=(
    "0.0.0.0" "10.0.0.0" "100.64.0.0" "127.0.0.0" "127.0.53.53" "169.254.0.0"
    "172.16.0.0" "192.0.0.0" "192.0.2.0" "192.168.0.0" "198.18.0.0"
    "198.51.100.0" "203.0.113.0" "224.0.0.0" "240.0.0.0" "255.255.255.255"
  )

  declare -r IPV6_BOGON_ARRAY=(
    "::" "::1" "::ffff:0:0" "::" "100::" "2001:10::" "2001:db8::" "fc00::"
    "fe80::" "fec0::" "ff00::"
  )

  declare -r IPV4_CIDR_BOGON_ARRAY=(
    "0.0.0.0/8" "10.0.0.0/8" "100.64.0.0/10" "127.0.0.0/8" "127.0.53.53/8"
    "169.254.0.0/16" "172.16.0.0/12" "192.0.0.0/24" "192.0.2.0/24" "192.168.0.0/16"
    "198.18.0.0/15" "198.51.100.0/24" "203.0.113.0/24" "224.0.0.0/4" "240.0.0.0/4"
    "255.255.255.255/32"
  )

  declare -r IPV6_CIDR_BOGON_ARRAY=(
    "::/128" "::1/128" "::ffff:0:0/96" "::/96" "100::/64" "2001:10::/28"
    "2001:db8::/32" "fc00::/7" "fe80::/10" "fec0::/10" "ff00::/8"
  )

  declare -r IPV4_DIALOG_ARRAY=(
    "'This' network" "Private-use networks" "Carrier-grade NAT" "Loopback"
    "Name collision occurrence" "Link local" "Private-use networks"
    "IETF protocol assignments" "TEST-NET-1" "Private-use networks"
    "Network interconnect device benchmark testing" "TEST-NET-2" "TEST-NET-3"
    "Multicast" "Reserved for future use" "Limited broadcast"
  )

  declare -r IPV6_DIALOG_ARRAY=(
    "Node-scope unicast unspecified address" "Node-scope unicast loopback address"
    "IPv4-mapped addresses" "IPv4-compatible addresses"
    "Remotely triggered black hole addresses"
    "Overlay routable cryptographic hash identifiers (ORCHID)"
    "Documentation prefix" "Unique local addresses (ULA)" "Link-local unicast"
    "Site-local unicast (deprecated)"
    "Multicast (Note: ff0e:/16 is global scope and may appear on the global internet)"
  )

  case "${1}" in
    "--normal")
      for IP in "${!IPV4_DIALOG_ARRAY[@]}"; do
        printf "%-16s%s\n" "${IPV4_BOGON_ARRAY[IP]}" "${IPV4_DIALOG_ARRAY[IP]}"
      done
      
      for IP in "${!IPV6_DIALOG_ARRAY[@]}"; do
        printf "%-16s%s\n" "${IPV6_BOGON_ARRAY[IP]}" "${IPV6_DIALOG_ARRAY[IP]}"
      done
      ;;
    "--cidr")
      for IP in "${!IPV4_DIALOG_ARRAY[@]}"; do
        printf "%-19s%s\n" "${IPV4_CIDR_BOGON_ARRAY[IP]}" "${IPV4_DIALOG_ARRAY[IP]}"
      done
      
      for IP in "${!IPV6_DIALOG_ARRAY[@]}"; do
        printf "%-19s%s\n" "${IPV6_CIDR_BOGON_ARRAY[IP]}" "${IPV6_DIALOG_ARRAY[IP]}"
      done
      ;;
  esac

  return 0
}

# Prints active network interfaces with their MAC address.
function show_mac() {
  
  local MAC_OF ITEM
  
  declare -r INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  
  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    MAC_OF=$(awk '{print $0}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/address" 2> /dev/null)
    echo "${INTERFACES_ARRAY[ITEM]}" "${MAC_OF}"
  done

  return 0
}

# Shows neighbor table.
function show_neighbor_cache() {
  
  local TEMP_FILE
  
  TEMP_FILE=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)

  ip neigh | awk 'tolower($0) ~ /permanent|noarp|stale|reachable|incomplete|delay|probe/{printf ("%-16s%-20s%s\n", $1, $5, $6)}' >> "${TEMP_FILE}"
  
  awk '{print $0}' "${TEMP_FILE}" | sort --version-sort

  return 0
}

# Prints connections and the count of them per IP.
function show_port_connections() {
  
  [ -z "${1}" ] && print_port_protocol_list && exit 0
  
  check_root_permissions
  check_if_parameter_is_positive_integer "${1}"
  
  local PORT="${1}"

  init_regexes
  
  clear
  while :; do
    clear
    echo -e "${DIALOG_PRESS_CTRL_C}"
    echo
    echo -e "      ${COLORS[2]}┌─> ${COLORS[1]}Count Port ${COLORS[2]}──┐"
    echo -e "      │ ┌───────> ${COLORS[1]}IPv4 ${COLORS[2]}└─> ${COLORS[1]}${PORT}"
    echo -e "    ${COLORS[2]}┌─┘ └──────────────┐${COLORS[0]}"
    ss --all --numeric --process | grep --extended-regexp "${REGEX_IPV4}" | grep ":${PORT}" | awk '{print $6}' | cut --delimiter=":" --fields=1 | sort --version-sort | uniq --count
    sleep 2
  done

  return 0
}

# Prints hops to a destination. $1=--ipv4|--ipv6, $2=network destination.
function show_next_hops() {
  
  local FILTERED_INPUT
  local PROTOCOL
  local TRACEPATH_CMD
  local TRACEROUTE_CMD
  local MTR_CMD
  local TEMP_FILE

  TEMP_FILE=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)

  hash tracepath &>/dev/null && TRACEPATH_CMD=1 || TRACEPATH_CMD=0
  hash traceroute &>/dev/null && TRACEROUTE_CMD=1 || TRACEROUTE_CMD=0
  hash mtr &>/dev/null && MTR_CMD=1 || MTR_CMD=0

  FILTERED_INPUT=$(echo "${2}" | sed 's/^http\(\|s\):\/\///g' | cut --fields=1 --delimiter="/")

  check_for_missing_args "${DIALOG_NO_ARGUMENTS}" "${FILTERED_INPUT}"
  
  case "${1}" in
    "--ipv4")
      PROTOCOL=4
      ;;
    "--ipv6")
      check_ipv6
      PROTOCOL=6
      ;;
  esac

  print_check "${FILTERED_INPUT}"

  check_destination "${FILTERED_INPUT}"

  init_regexes

  function trace_hops() {
    
    # traceroute is deprecated, nevertheless it is preferred over all
    case "${TRACEPATH_CMD}:${TRACEROUTE_CMD}:${MTR_CMD}" in
      # If none of the tools (tracepath, traceroute, mtr) is installed
      0:0:0)
        echo -e "${DIALOG_NO_TRACE_COMMAND}"
        ;;
      # If it is installed 'mtr' only
      0:0:1)
        case "${PROTOCOL}" in
          4)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'traceroute' only
      0:1:0)
        case "${PROTOCOL}" in
          4)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'traceroute' and 'mtr' only
      0:1:1)
        case "${PROTOCOL}" in
          4)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'tracepath' only
      1:0:0)
        # tracepath6 workaround: Many linux distributions do not have tracepath6 (it is included in manpages tho :/)
        hash tracepath6 &>/dev/null && PROTOCOL=6
        [ "${PROTOCOL}" -eq 4 ] && echo -e "${DIALOG_NO_TRACEPATH6}"

        case "${PROTOCOL}" in
          4)
            timeout "${SHORT_TIMEOUT}" tracepath"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              awk '{print $2}' | \
                grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            timeout "${SHORT_TIMEOUT}" tracepath"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              awk '{print $2}' | \
                grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'tracepath' and 'mtr' only
      1:0:1)
        case "${PROTOCOL}" in
          4)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            mtr -"${PROTOCOL}" --report-cycles 2 --no-dns --report "${FILTERED_INPUT}" 2> /dev/null | \
              grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'tracepath' and 'traceroute' only
      1:1:0)
        case "${PROTOCOL}" in
          4)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
      # If it is installed 'tracepath', 'traceroute' and 'mtr'
      1:1:1)
        case "${PROTOCOL}" in
          4)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV4}"
            ;;
          6)
            timeout "${SHORT_TIMEOUT}" traceroute -"${PROTOCOL}" -n "${FILTERED_INPUT}" 2> /dev/null | \
              tail --lines=+2 | \
                grep --extended-regexp --only-matching "${REGEX_IPV6}"
            ;;
        esac
        ;;
    esac >> "${TEMP_FILE}"
  }

  clear_line
  echo -ne "Tracing path to ${COLORS[2]}${FILTERED_INPUT}${COLORS[0]} ..."
  trace_hops

  # Ensure that TEMP_FILE is written on /tmp
  while [ ! -f "${TEMP_FILE}" ]; do
    trace_hops
  done
  
  clear_line
  awk '!seen[$0]++ {print}' "${TEMP_FILE}"

  return 0
}

# Shows broadcast, network address, cisco wildcard mask, class and host range by given IPv4 address and netmask.
function show_ipcalc() {

  local NOBINARY HTML
  local IFS CIDR
  local DECIMAL_POINTS BITS
  local HOSTS HOST_MINIMUM HOST_MINIMUM_BINARY HOST_MAXIMUM HOST_MAXIMUM_BINARY
  local CLASS CLASS_DESCRIPTION
  local IP IP_BINARY
  local NETMASK NETMASK_BINARY
  local WILDCARD WILDCARD_BINARY
  local NETWORK_ADDRESS NETWORK_ADDRESS_BINARY
  local BROADCAST_ADDRESS BROADCAST_ADDRESS_BINARY
  local IP_PART_A IP_PART_B IP_PART_C IP_PART_D
  local NETMASK_PART_A NETMASK_PART_B NETMASK_PART_C NETMASK_PART_D
  local PART_A PART_B PART_C PART_D

  NOBINARY=0
  HTML=0

  case "${1}" in
    "-b"|"--nobinary")
      NOBINARY=1
      shift
      ;;
    "-h"|"--html")
      HTML=1
      shift
      ;;
  esac

  case "${1}" in
    "-b"|"--nobinary")
      NOBINARY=1
      shift
      ;;
    "-h"|"--html")
      HTML=1
      shift
      ;;
  esac

  init_regexes

  # pass the input into a variable
  IP=$(grep --extended-regexp "${REGEX_IPV4}" <<< "${1}")
  # check only the IP part
  check_dotted_quad_address "$(awk -F '/' '{print $1}' <<< "${IP}")"

  # if ipv4/cidr
  if grep --extended-regexp --only-matching "${REGEX_IPV4_CIDR}" <<< "${1}" &> /dev/null; then
    CIDR=$(awk -F '/' '{print $2}' <<< "${1}")
    # if no CIDR is specified then pass the default value
    [ ! "${CIDR}" ] && CIDR="24" # default notation
    # check for non numerical CIDR
    [[ ! "${CIDR}" =~ ^[0-9]+$ ]] && error_exit "${DIALOG_NO_VALID_CIDR}"
    # check if cidr is < 0 or > 32
    [[ "${CIDR}" -lt 1 || "${CIDR}" -gt 32 ]] && error_exit "${DIALOG_NO_VALID_CIDR}"

    # calculate netmask
    NETMASK=$(( 0xffffffff ^ (( 1 << ( 32 - CIDR )) -1 ) ))
    NETMASK=$(( ( NETMASK >> 24 ) & 0xff )).$(( ( NETMASK >> 16 ) & 0xff )).$(( ( NETMASK >> 8 ) & 0xff )).$(( NETMASK & 0xff ))

    IFS=.
    # split netmask into multiple parts for better ease
    read -r NETMASK_PART_A NETMASK_PART_B NETMASK_PART_C NETMASK_PART_D <<< "${NETMASK}"
    # convert netmask to binary
    NETMASK_BINARY="$(dec_to_bin "${NETMASK_PART_A}").$(dec_to_bin "${NETMASK_PART_B}").$(dec_to_bin "${NETMASK_PART_C}").$(dec_to_bin "${NETMASK_PART_D}")"
  # if only ipv4 and no CIDR
  elif grep --extended-regexp --only-matching "${REGEX_IPV4}" <<< "${1}" &> /dev/null; then
    # if no netmask was specified keep the default value
    if [[ -z "${2}" ]]; then NETMASK="255.255.255.0"; else NETMASK="${2}"; fi

    IFS=.
    declare -a NETMASK_ARRAY
    # split netmask into parts and pass them into an array
    NETMASK_ARRAY=($(tr " " "\n" <<< "${NETMASK}"))
    
    # check if netmask is valid
    check_dotted_quad_address "${NETMASK}"
    # if netmask first part is 0
    [ "${NETMASK_ARRAY[0]}" -eq 0 ] && echo -e "${DIALOG_NO_VALID_MASK}" && show_usage_subnet && error_exit
    
    # iterate through netmask and validate
    for POSITION in "${!NETMASK_ARRAY[@]}"; do
      case "${NETMASK_ARRAY[POSITION]}" in
        255) ;; 254) ;; 252) ;; 248) ;; 240) ;;
        224) ;; 192) ;; 128) ;;   0) ;;
        *)
          echo -e "${DIALOG_NO_VALID_MASK}"
          show_usage_subnet
          error_exit
        ;;
      esac
    done

    # pass netmask array values into variables for better ease
    NETMASK_PART_A="${NETMASK_ARRAY[0]}"; NETMASK_PART_B="${NETMASK_ARRAY[1]}"
    NETMASK_PART_C="${NETMASK_ARRAY[2]}"; NETMASK_PART_D="${NETMASK_ARRAY[3]}"

    # convert netmask to binary
    NETMASK_BINARY="$(dec_to_bin "${NETMASK_PART_A}").$(dec_to_bin "${NETMASK_PART_B}").$(dec_to_bin "${NETMASK_PART_C}").$(dec_to_bin "${NETMASK_PART_D}")"
    # convert netmask to CIDR
    CIDR=$(echo "${NETMASK_BINARY}" | grep --only-matching 1 | wc --lines)
  else
    show_usage_subnet
    error_exit
  fi

  # remove CIDR from IP address
  IP=$(awk -F '/' '{print $1}' <<< "${IP}")

  # pass IP parts into multiple variables for future checks
  read -r IP_PART_A IP_PART_B IP_PART_C IP_PART_D <<< "${IP}"
  # convert IP to binary
  IP_BINARY="$(dec_to_bin "${IP_PART_A}").$(dec_to_bin "${IP_PART_B}").$(dec_to_bin "${IP_PART_C}").$(dec_to_bin "${IP_PART_D}")"

  # calculate wildcard in binary
  WILDCARD_BINARY=$(tr 01 10 <<< "${NETMASK_BINARY}") # inverse the address
  # pass wildcard parts into multiple variables for future checks
  read -r PART_A PART_B PART_C PART_D <<< "${WILDCARD_BINARY}"

  # convert wildcard to decimal
  WILDCARD="$(bin_to_dec "${PART_A}").$(bin_to_dec "${PART_B}").$(bin_to_dec "${PART_C}").$(bin_to_dec "${PART_D}")"

  # calculate network address by => parts of ip address AND parts of netmask address
  NETWORK_ADDRESS=$(( IP_PART_A & NETMASK_PART_A )).$(( IP_PART_B & NETMASK_PART_B )).$(( IP_PART_C & NETMASK_PART_C )).$(( IP_PART_D & NETMASK_PART_D ))
  # split network address into parts for better ease
  PART_A=$(cut --delimiter='.' --fields=1 <<< "${NETWORK_ADDRESS}"); PART_B=$(cut --delimiter='.' --fields=2 <<< "${NETWORK_ADDRESS}")
  PART_C=$(cut --delimiter='.' --fields=3 <<< "${NETWORK_ADDRESS}"); PART_D=$(cut --delimiter='.' --fields=4 <<< "${NETWORK_ADDRESS}")
  # convert network address to binary
  NETWORK_ADDRESS_BINARY="$(dec_to_bin "${PART_A}").$(dec_to_bin "${PART_B}").$(dec_to_bin "${PART_C}").$(dec_to_bin "${PART_D}")"

  # calculate host bits
  HOST_BITS=$(echo "${NETMASK_BINARY}" | grep --only-matching 0 | wc --lines) # count how many 0s are there in netmask binary

  # calculate first usable IP address
  PART_D=$(( PART_D + 1 )) # add 1 to the last octet of the network address
  HOST_MINIMUM="${PART_A}.${PART_B}.${PART_C}.${PART_D}" # merge decimal parts
  HOST_MINIMUM_BINARY=$(dec_to_bin "${PART_A}").$(dec_to_bin "${PART_B}").$(dec_to_bin "${PART_C}").$(dec_to_bin "${PART_D}") # convert to binary

  BROADCAST_ADDRESS_BINARY="${IP_BINARY//.}" # remove dots and merge strings together
  BROADCAST_ADDRESS_BINARY="${BROADCAST_ADDRESS_BINARY:0:${#BROADCAST_ADDRESS_BINARY}-${HOST_BITS}}" # remove last bits, as many as HOST_BITS are

  # append bits to trimmed binary
  BITS=$(( 32 - HOST_BITS ))
  until [[ "${BITS}" -eq 32 ]]; do
    BROADCAST_ADDRESS_BINARY+="1" # append a bit every loop
    let BITS+=1
  done

  # put a dot every 8th character and remove last occurence of dot
  BROADCAST_ADDRESS_BINARY=$(sed --expression="s/\(.\{8\}\)/\1./g" --expression="s/\(.*\)./\1 /" <<< "${BROADCAST_ADDRESS_BINARY}")

  # split broadcast address binary into parts for better ease
  PART_A=$(cut --delimiter='.' --fields=1 <<< "${BROADCAST_ADDRESS_BINARY}"); PART_B=$(cut --delimiter='.' --fields=2 <<< "${BROADCAST_ADDRESS_BINARY}")
  PART_C=$(cut --delimiter='.' --fields=3 <<< "${BROADCAST_ADDRESS_BINARY}"); PART_D=$(cut --delimiter='.' --fields=4 <<< "${BROADCAST_ADDRESS_BINARY}")
  # convert broadcast address binary to decimal
  BROADCAST_ADDRESS="$(bin_to_dec "${PART_A}").$(bin_to_dec "${PART_B}").$(bin_to_dec "${PART_C}").$(bin_to_dec "${PART_D}")"
  
  # calculate last usable IP address
  PART_D=$(bin_to_dec "${PART_D}") # convert to decimal in order to substract later
  PART_D=$(( PART_D - 1 )) # substract 1 from the last octet of the broadcast address
  PART_D=$(dec_to_bin "${PART_D}") # convert to binary
  HOST_MAXIMUM=$(bin_to_dec "${PART_A}").$(bin_to_dec "${PART_B}").$(bin_to_dec "${PART_C}").$(bin_to_dec "${PART_D}") # merge parts and convert them to decimals
  HOST_MAXIMUM_BINARY="${PART_A}.${PART_B}.${PART_C}.${PART_D}" # merge binary parts

  # maximum Number of hosts
  HOSTS=$(( 2 ** ( 32 - CIDR ) - 2 ))
  
  # classful addressing: leading bits checking
  IP_PART_A=$(dec_to_bin "${IP_PART_A}") # convert first octet to binary
  # find class by checking first 0-4 bits
  case "${IP_PART_A}" in
       0*) CLASS="A" ;;
      10*) CLASS="B" ;;
     110*) CLASS="C" ;;
    1110*) CLASS="D" ;;
    1111*) CLASS="E" ;;
  esac
  
  # RFC 1918 based
  IP_PART_B=$(dec_to_bin "${IP_PART_B}") # convert second octet to binary
  # describe the IP address by checking the first two octets
  case "${IP_PART_A}:${IP_PART_B}" in
    01111111:*) CLASS_DESCRIPTION="Loopback" ;;
    00001010:*) CLASS_DESCRIPTION="Private Internet" ;;
    10101100:0001*) CLASS_DESCRIPTION="Private Internet" ;;
    11000000:10101000) CLASS_DESCRIPTION="Private Internet" ;;
    1110*:*) CLASS_DESCRIPTION="Multicast" ;;
    1111*:*) CLASS_DESCRIPTION="Experimental" ;;
  esac

  # describe IP address by checking the CIDR 30-32 
  case "${CIDR}" in
    30)
      CLASS_DESCRIPTION+=", Glue Network PtP Link"
      ;;
    31)
      CLASS_DESCRIPTION+=", PtP Link RFC 3021"
      HOSTS=2
      HOST_MINIMUM="${NETWORK_ADDRESS}"
      HOST_MINIMUM_BINARY="${NETWORK_ADDRESS_BINARY}"
      IP_PART_A=$(bin_to_dec "${IP_PART_A}")
      IP_PART_B=$(bin_to_dec "${IP_PART_B}")
      # calculates properly host range
      [ $(( IP_PART_D % 2 )) -eq 0 ] \
        && IP_PART_D=$(( IP_PART_D + 1 )) \
        && HOST_MAXIMUM="${IP_PART_A}.${IP_PART_B}.${IP_PART_C}.${IP_PART_D}" \
        && HOST_MAXIMUM_BINARY=$(dec_to_bin "${IP_PART_A}").$(dec_to_bin "${IP_PART_B}").$(dec_to_bin "${IP_PART_C}").$(dec_to_bin "${IP_PART_D}") \
        || HOST_MAXIMUM="${IP}" \
        || HOST_MAXIMUM_BINARY="${IP_BINARY}"
      ;;
    32)
      CLASS_DESCRIPTION+=", Hostroute"
      HOSTS=1 # number of hosts workaround
      ;;
  esac

  IFS=

  function print_with_binary() {

    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Address:" "${IP}" "${IP_BINARY}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Address (dec):" "$(dotted_quad_ip_to_decimal "${IP}")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Address (hex):" "$(dec_to_hex "$(dotted_quad_ip_to_decimal "${IP}")")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[1]}%s${COLORS[0]}\n" "Netmask:" "${NETMASK} = ${CIDR}" "${NETMASK_BINARY}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[1]}%s${COLORS[0]}\n" "Netmask (hex):" "$(dec_to_hex "$(dotted_quad_ip_to_decimal "${NETMASK}")")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Wildcard:" "${WILDCARD}" "${WILDCARD_BINARY}"
    printf "=>\n"
    [ "${CIDR}" -le 31 ] \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Network:" "${NETWORK_ADDRESS}/${CIDR}" "${NETWORK_ADDRESS_BINARY}" \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "HostMin:" "${HOST_MINIMUM}" "${HOST_MINIMUM_BINARY}" \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "HostMax:" "${HOST_MAXIMUM}" "${HOST_MAXIMUM_BINARY}" \
      || printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Hostroute:" "${IP}" "${IP_BINARY}"
    [ "${CIDR}" -le 30 ] \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Broadcast:" "${BROADCAST_ADDRESS}" "${BROADCAST_ADDRESS_BINARY}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[5]}%s${COLORS[0]}%-22s${COLORS[4]}\n" "Hosts/Net:" "${HOSTS}" "Class ${CLASS}" " ${CLASS_DESCRIPTION}"
    echo -e "${COLORS[0]}" # revert color back to normal
  }

  function print_without_binary() {
    
    printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n"               "Address:" "${IP}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Address (dec):" "$(dotted_quad_ip_to_decimal "${IP}")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[3]}%s${COLORS[0]}\n" "Address (hex):" "$(dec_to_hex "$(dotted_quad_ip_to_decimal "${IP}")")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n"               "Netmask:" "${NETMASK} = ${CIDR}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[1]}%s${COLORS[0]}\n" "Netmask (hex):" "$(dec_to_hex "$(dotted_quad_ip_to_decimal "${NETMASK}")")"
    printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n"               "Wildcard:" "${WILDCARD}"
    printf "=>\n"
    [ "${CIDR}" -le 31 ] \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n" "Network:"   "${NETWORK_ADDRESS}/${CIDR}" \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n" "HostMin:"   "${HOST_MINIMUM}" \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n" "HostMax:"   "${HOST_MAXIMUM}" \
      || printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n" "Hostroute:" "${IP}"
    [ "${CIDR}" -le 30 ] \
      && printf "%-16s${COLORS[4]}%-21s${COLORS[0]}\n"                           "Broadcast:" "${BROADCAST_ADDRESS}"
    printf "%-16s${COLORS[4]}%-21s${COLORS[5]}%s${COLORS[0]}%-22s${COLORS[4]}\n" "Hosts/Net:" "${HOSTS}" "Class ${CLASS}" " ${CLASS_DESCRIPTION}"
    echo -e "${COLORS[0]}" # revert color back to normal
  }

  function print_html_with_binary() {

    cat << EOF
      <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8"/>
            <title>ship.sh</title>
            <style>
              @import url(//fonts.googleapis.com/css?family=Source+Code+Pro);

              .ascii_art {
                font-size:   10pt;
                font-family: "Source Code Pro", Courier, monospace;
                white-space: pre
                color:       green;
              }

              .text {
                font-size:   13pt;
                font-family: "Source Code Pro", Courier, monospace;
                font-weight: light;
                color:       #F0F0F0;
              }

              .ip {
                font-size:   13pt;
                font-family: "Source Code Pro", Courier, monospace;
                font-weight: 800;
                color:       #2F888B;
              }

              .binary {
                font-size:   13pt;
                font-family: "Source Code Pro", Courier, monospace;
                font-weight: light;
                color:       #0D5A63;
              }

              #inlineParagraph {
                display:     inline;
              }

              html {
                position:    relative;
                min-height:  100%;
              }
              
              body {
                margin:           0 0 100px;
                padding:          25px;
                background-color: #000000;
              }
              
              footer {
                position:         absolute;
                left:             0;
                bottom:           0;
                height:           100px;
                width:            100%;
                overflow:         hidden;
                color:            #2F888B;
              }

              table {
                border-collapse: collapse;
                border:          1px solid black;
              }

              td {
                text-align:       left;
                padding-left:     7px;
                padding-right:    7px;
              }
            </style>
        </head>
        <body>
        <a href="https://github.com/xtonousou/shIP"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
        <table>
        <tr>
          <td class="text">Address:</td>
          <td class="ip">${IP}</td>
          <td class="binary">${IP_BINARY}</td>
        </tr> 
        <tr>
          <td class="text">Address (dec):</td>
          <td class="ip">$(dotted_quad_ip_to_decimal "${IP}")</td>
        </tr>
        <tr>
          <td class="text">Address (hex):</td>
          <td class="ip">$(dec_to_hex "$(dotted_quad_ip_to_decimal "${IP}")")</td>
        </tr>
        <tr>
          <td class="text">Netmask:</td>
          <td class="ip">${NETMASK} = ${CIDR}</td>
          <td class="binary">${NETMASK_BINARY}</td>
        </tr>
        <tr>
          <td class="text">Netmask (hex):</td>
          <td class="ip">$(dec_to_hex "$(dotted_quad_ip_to_decimal "${NETMASK}")")</td>
        </tr>
        <tr>
          <td class="text">Wildcard:</td>
          <td class="ip">${WILDCARD}</td>
          <td class="binary">${WILDCARD_BINARY}</td>
        </tr>
        <tr>
          <td class="text">=></td>
        </tr>
EOF
    [ "${CIDR}" -le 31 ] \
      && cat << EOF
        <tr>
          <td class="text">Network:</td>
          <td class="ip">${NETWORK_ADDRESS}/${CIDR}</td>
          <td class="binary">${NETWORK_ADDRESS_BINARY}</td>
        </tr>
        <tr>
          <td class="text">HostMin:</td>
          <td class="ip">${HOST_MINIMUM}</td>
          <td class="binary">${HOST_MINIMUM_BINARY}</td>
        </tr>
        <tr>
          <td class="text">HostMax:</td>
          <td class="ip">${HOST_MAXIMUM}</td>
          <td class="binary">${HOST_MAXIMUM_BINARY}</td>
        </tr>
EOF
    [ "${CIDR}" -eq 32 ] \
      && cat << EOF
        <tr>
          <td class="text">Hostroute:</td>
          <td class="ip">${IP}</td>
          <td class="binary">${IP_BINARY}</td>
        </tr>
EOF
    [ "${CIDR}" -le 30 ] \
      && cat << EOF
        <tr>
          <td class="text">Broadcast:</td>
          <td class="ip">${BROADCAST_ADDRESS}</td>
          <td class="binary">${BROADCAST_ADDRESS_BINARY}</td>
        </tr>
EOF
    cat <<- EOF
      <tr>
        <td class="text">Hosts/Net:</td>
        <td class="ip">${HOSTS}</td>
        <td><p id="inlineParagraph" class="ip">Class ${CLASS}</p><p id="inlineParagraph" class="text">&nbsp;${CLASS_DESCRIPTION}</p></td>
      </tr>
      </table>
      </body>
      <footer>
      <p align="center">
        Made with <3 by Sotirios Roussis (aka. xToNouSou)<br/>
        Contact information: <a href="mailto:xtonousou@gmail.com">xtonousou@gmail.com</a><br/>
      </p>
      </footer>
      </html>
EOF
  }

  function print_html_without_binary() {

    cat << EOF
      <!DOCTYPE html>
        <html>
          <head>
            <meta charset="UTF-8"/>
            <title>ship.sh</title>
            <style>
              @import url(//fonts.googleapis.com/css?family=Source+Code+Pro);

              .ascii_art {
                font-size:   10pt;
                font-family: "Source Code Pro", Courier, monospace;
                white-space: pre
                color:       green;
              }

              .text {
                font-size:   13pt;
                font-family: "Source Code Pro", Courier, monospace;
                font-weight: light;
                color:       #F0F0F0;
              }

              .ip {
                font-size:   13pt;
                font-family: "Source Code Pro", Courier, monospace;
                font-weight: 800;
                color:       #2F888B;
              }

              #inlineParagraph {
                display:     inline;
              }

              html {
                position:    relative;
                min-height:  100%;
              }
              
              body {
                margin:           0 0 100px;
                padding:          25px;
                background-color: #000000;
              }
              
              footer {
                position:         absolute;
                left:             0;
                bottom:           0;
                height:           100px;
                width:            100%;
                overflow:         hidden;
                color:            #2F888B;
              }

              table {
                border-collapse: collapse;
                border:          1px solid black;
              }

              td {
                text-align:       left;
                padding-left:     7px;
                padding-right:    7px;
              }
            </style>
        </head>
        <body>
        <a href="https://github.com/xtonousou/shIP"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
        <table>
        <tr>
          <td class="text">Address:</td>
          <td class="ip">${IP}</td>
        </tr> 
        <tr>
          <td class="text">Address (dec):</td>
          <td class="ip">$(dotted_quad_ip_to_decimal "${IP}")</td>
        </tr>
        <tr>
          <td class="text">Address (hex):</td>
          <td class="ip">$(dec_to_hex "$(dotted_quad_ip_to_decimal "${IP}")")</td>
        </tr>
        <tr>
          <td class="text">Netmask:</td>
          <td class="ip">${NETMASK} = ${CIDR}</td>
        </tr>
        <tr>
          <td class="text">Netmask (hex):</td>
          <td class="ip">$(dec_to_hex "$(dotted_quad_ip_to_decimal "${NETMASK}")")</td>
        </tr>
        <tr>
          <td class="text">Wildcard:</td>
          <td class="ip">${WILDCARD}</td>
        </tr>
        <tr>
          <td class="text">=></td>
        </tr>
EOF
    [ "${CIDR}" -le 31 ] \
      && cat << EOF
        <tr>
          <td class="text">Network:</td>
          <td class="ip">${NETWORK_ADDRESS}/${CIDR}</td>
        </tr>
        <tr>
          <td class="text">HostMin:</td>
          <td class="ip">${HOST_MINIMUM}</td>
        </tr>
        <tr>
          <td class="text">HostMax:</td>
          <td class="ip">${HOST_MAXIMUM}</td>
        </tr>
EOF
    [ "${CIDR}" -eq 32 ] \
      && cat << EOF
        <tr>
          <td class="text">Hostroute:</td>
          <td class="ip">${IP}</td>
        </tr>
EOF
    [ "${CIDR}" -le 30 ] \
      && cat << EOF
        <tr>
          <td class="text">Broadcast:</td>
          <td class="ip">${BROADCAST_ADDRESS}</td>
        </tr>
EOF
    cat <<- EOF
      <tr>
        <td class="text">Hosts/Net:</td>
        <td class="ip">${HOSTS}</td>
        <td><p id="inlineParagraph" class="ip">Class ${CLASS}</p><p id="inlineParagraph" class="text">&nbsp;${CLASS_DESCRIPTION}</p></td>
      </tr>
      </table>
      </body>
      <footer>
      <p align="center">
        Made with <3 by Sotirios Roussis (aka. xToNouSou)<br/>
        Contact information: <a href="mailto:xtonousou@gmail.com">xtonousou@gmail.com</a><br/>
      </p>
      </footer>
      </html>
EOF
  }

  case "${NOBINARY}:${HTML}" in
    0:0) print_with_binary ;;
    0:1) print_html_with_binary ;;
    1:0) print_without_binary ;;
    1:1) print_html_without_binary ;;
  esac

  return 0
}

# Extracts valid IPv4, IPv6 and MAC addresses from URLs.
function show_ips_from_online_documents() {

  check_for_missing_args "No URL was specified. ${DIALOG_ABORTING}" "${1}"

  local HTTP_CODE DOCUMENT
  local TEMP_FILE_IPV4 TEMP_FILE_IPV6 TEMP_FILE_MAC TEMP_FILE_HTML
  local IS_TEMP_FILE_IPV4_EMPTY IS_TEMP_FILE_IPV6_EMPTY IS_TEMP_FILE_MAC_EMPTY

  TEMP_FILE_IPV4=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
  TEMP_FILE_IPV6=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
  TEMP_FILE_MAC=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)
  TEMP_FILE_HTML=$(mktemp "${TEMP}"/"${SCRIPT_NAME}".XXXXXXXXXX)

  init_regexes

  for DOCUMENT in "${@}"; do
    print_check "${DOCUMENT}"
    HTTP_CODE=$(wget --spider --tries 1 --timeout="${TIMEOUT}" --server-response "${DOCUMENT}" 2>&1 | awk '/HTTP\//{print $2}' | tail --lines=1)
    
    clear_line
    [ ! "${HTTP_CODE}" = "200" ] \
      && error_exit "${COLORS[3]}${DOCUMENT}${COLORS[0]} is unreachable. Input was invalid or server is down or has connection issues. ${DIALOG_ABORTING}"

    echo -ne "Downloading ${COLORS[2]}$1${COLORS[0]} ..."
    wget "${DOCUMENT}" --quiet --output-document="${TEMP_FILE_HTML}"

    # Ensure that TEMP_FILE_HTML is written on /tmp
    while [ ! -f "${TEMP_FILE_HTML}" ]; do
      wget "${DOCUMENT}" --quiet --output-document="${TEMP_FILE_HTML}"
    done

    clear_line
    grep --extended-regexp --only-matching "${REGEX_IPV4}" "${TEMP_FILE_HTML}" >> "${TEMP_FILE_IPV4}"
    grep --extended-regexp --only-matching "${REGEX_IPV6}" "${TEMP_FILE_HTML}" >> "${TEMP_FILE_IPV6}"
    grep --extended-regexp --only-matching "${REGEX_MAC}" "${TEMP_FILE_HTML}" >> "${TEMP_FILE_MAC}"
  done

  [ -s "${TEMP_FILE_IPV4}" ] && IS_TEMP_FILE_IPV4_EMPTY=0 || IS_TEMP_FILE_IPV4_EMPTY=1
  [ -s "${TEMP_FILE_IPV6}" ] && IS_TEMP_FILE_IPV6_EMPTY=0 || IS_TEMP_FILE_IPV6_EMPTY=1
  [ -s "${TEMP_FILE_MAC}" ] && IS_TEMP_FILE_MAC_EMPTY=0 || IS_TEMP_FILE_MAC_EMPTY=1

  sort --version-sort --unique --output="${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV4}"
  sort --version-sort --unique --output="${TEMP_FILE_IPV6}" "${TEMP_FILE_IPV6}"
  sort --version-sort --unique --output="${TEMP_FILE_MAC}" "${TEMP_FILE_MAC}"

  case "${IS_TEMP_FILE_IPV4_EMPTY}:${IS_TEMP_FILE_IPV6_EMPTY}:${IS_TEMP_FILE_MAC_EMPTY}" in
    0:0:0) # IPv4, IPv6 and MAC addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV6}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-15s │ %-39s │ %s\n", $1, tolower($2), tolower($3))}'
      ;;
    0:0:1) # Only IPv4 and IPv6 addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_IPV6}" | \
        awk -F '\t' '{printf("%-15s │ %s\n", $1, tolower($2))}'
      ;;
    0:1:0) # Only IPv4 and MAC addresses
      paste "${TEMP_FILE_IPV4}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-15s │ %s\n", $1, tolower($2))}'
      ;;
    0:1:1) # Only IPv4 addresses
      paste "${TEMP_FILE_IPV4}" | \
        awk -F '\t' '{printf("%s\n", $1)}'
      ;;
    1:0:0) # Only IPv6 and MAC addresses
      paste "${TEMP_FILE_IPV6}" "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%-39s │ %s\n", tolower($1), tolower($2))}'
      ;;
    1:0:1) # Only IPv6 addresses
      paste "${TEMP_FILE_IPV6}" | \
        awk -F '\t' '{printf("%s\n", tolower($1))}'
      ;;
    1:1:0) # Only MAC addresses
      paste "${TEMP_FILE_MAC}" | \
        awk -F '\t' '{printf("%s\n", tolower($1))}'
      ;;
    1:1:1) # None
      error_exit "${DIALOG_NO_VALID_ADDRESSES}"
      ;;
  esac

  return 0
}

# Prints script's version and author's info.
function show_version() {

  echo -e "${COLORS[4]}"
  echo -e "   ▄▄▄▄▄    ▄  █ ▄█ █ ▄▄"
  echo -e "  █     ▀▄ █   █ ██ █   █ \t ${COLORS[0]}Author .: ${COLORS[4]}${AUTHOR} - xtonousou"
  echo -e "▄  ▀▀▀▀▄   ██▀▀█ ██ █▀▀▀ \t ${COLORS[0]}Mail ...: ${COLORS[4]}${GMAIL}"
  echo -e " ▀▄▄▄▄▀    █   █ ▐█ █ \t\t ${COLORS[0]}Github .: ${COLORS[4]}${GITHUB}"
  echo -e "              █   ▐  █ \t\t ${COLORS[0]}Version : ${COLORS[4]}${VERSION}"
  echo -e "             ▀        ▀"
  echo -e "${COLORS[0]}"

  return 0
}

# Prints active network interfaces with their IPv4 address and CIDR suffix.
function show_ipv4_cidr() {

  local ITEM

  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV4_CIDR_ARRAY
  
  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV4_CIDR_ARRAY[ITEM]=$(ip -4 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family=inet '$0 ~ family {print $2}')
    echo "${INTERFACES_ARRAY[ITEM]}" "${IPV4_CIDR_ARRAY[ITEM]}"
  done

  return 0
}

# Prints active network interfaces with their IPv6 address and CIDR suffix.
function show_ipv6_cidr() {

  check_ipv6

  local ITEM
  
  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV6_CIDR_ARRAY

  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV6_CIDR_ARRAY[ITEM]=$(ip -6 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family="inet6" 'tolower($0) ~ family {print $2}')
    echo "${INTERFACES_ARRAY[ITEM]}" "${IPV6_CIDR_ARRAY[ITEM]}"
  done

  return 0
}

# Prints all info and CIDR suffix.
function show_all_cidr() {

  check_ipv6
  
  local MAC_OF
  local DRIVER_OF
  local GATEWAY
  local CIDR
  local ITEM
  
  declare INTERFACES_ARRAY=($(ip route | awk 'tolower($0) ~ /default/ {print $5}'))
  declare IPV4_CIDR_ARRAY
  declare IPV6_CIDR_ARRAY
  
  for ITEM in "${!INTERFACES_ARRAY[@]}"; do
    IPV4_CIDR_ARRAY[ITEM]=$(ip -4 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family=inet '$0 ~ family {print $2}')
    IPV6_CIDR_ARRAY[ITEM]=$(ip -6 address show dev "${INTERFACES_ARRAY[ITEM]}" | awk -v family="inet6" 'tolower($0) ~ family {print $2}')
    [ -f "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent" ] \
      && DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/phy80211/device/uevent") \
      || DRIVER_OF=$(awk -F '=' 'tolower($0) ~ /driver/{print $2}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/device/uevent")
    MAC_OF=$(awk '{print $0}' "/sys/class/net/${INTERFACES_ARRAY[ITEM]}/address" 2> /dev/null)
    GATEWAY=$(ip route | awk "/${INTERFACES_ARRAY[ITEM]}/ && tolower(\$0) ~ /default/ {print \$3}")
    CIDR=$(echo -n "${IPV4_CIDR_ARRAY[ITEM]}" | sed 's/^.*\//\//')
    echo "${INTERFACES_ARRAY[ITEM]}" "${DRIVER_OF}" "${MAC_OF}" "${GATEWAY}${CIDR}" "${IPV4_CIDR_ARRAY[ITEM]}" "${IPV6_CIDR_ARRAY[ITEM]}"
  done

  return 0
}

# Prints help message.
function show_usage() {
  
  echo    " usage: ${SCRIPT_NAME} [OPTION] <ARGUMENT/S>"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-4 ${COLORS[0]}, ${COLORS[0]}--ipv4 ${COLORS[0]}          shows active interfaces with their IPv4 address"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-6 ${COLORS[0]}, ${COLORS[0]}--ipv6 ${COLORS[0]}          shows active interfaces with their IPv6 address"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-a ${COLORS[0]}, ${COLORS[0]}--all ${COLORS[0]}           shows all information"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-A ${COLORS[0]}, ${COLORS[0]}--all-interfaces ${COLORS[0]}shows all available network interfaces"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-c ${COLORS[0]}, ${COLORS[0]}--calculate ${COLORS[0]}<>   shows calculated IP information"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-d ${COLORS[0]}, ${COLORS[0]}--driver ${COLORS[0]}        shows each active interface's driver"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-e ${COLORS[0]}, ${COLORS[0]}--external ${COLORS[0]}      shows your external IP address"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-e ${COLORS[0]}, ${COLORS[0]}--external ${COLORS[0]}<>    shows external IP addresses"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-f ${COLORS[0]}, ${COLORS[0]}--find ${COLORS[0]}<>        shows valid IP and MAC addresses found on file/s"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-g ${COLORS[0]}, ${COLORS[0]}--gateway ${COLORS[0]}       shows gateway of online interfaces"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-h ${COLORS[0]}, ${COLORS[0]}--help${COLORS[0]}           shows this help message"
  echo -e "  ${SCRIPT_NAME} ${COLORS[1]}-H ${COLORS[0]}, ${COLORS[1]}--hosts ${COLORS[0]}         shows active hosts on network"
  echo -e "  ${SCRIPT_NAME} ${COLORS[1]}-HM${COLORS[0]}, ${COLORS[1]}--hosts-mac ${COLORS[0]}     shows active hosts on network with their MAC address"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-i ${COLORS[0]}, ${COLORS[0]}--interfaces ${COLORS[0]}    shows active interfaces"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-l ${COLORS[0]}, ${COLORS[0]}--list ${COLORS[0]}          shows a list of private and reserved IP addresses"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-m ${COLORS[0]}, ${COLORS[0]}--mac ${COLORS[0]}           shows active interfaces with their MAC address"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-n ${COLORS[0]}, ${COLORS[0]}--neighbor ${COLORS[0]}      shows neighbor cache"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-P ${COLORS[0]}, ${COLORS[0]}--port ${COLORS[0]}          shows a list of common ports"
  echo -e "  ${SCRIPT_NAME} ${COLORS[1]}-P ${COLORS[0]}, ${COLORS[1]}--port ${COLORS[0]}<>        shows connections to a port per IP"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-r ${COLORS[0]}, ${COLORS[0]}--route-ipv4 ${COLORS[0]}<>  shows the path to a network host using IPv4"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-r6${COLORS[0]}, ${COLORS[0]}--route-ipv6 ${COLORS[0]}<>  shows the path to a network host using IPv6"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-u ${COLORS[0]}, ${COLORS[0]}--url ${COLORS[0]}<>         shows valid IP and MAC addresses found on website/s"
  echo -e "  ${SCRIPT_NAME} ${COLORS[0]}-v ${COLORS[0]}, ${COLORS[0]}--version ${COLORS[0]}       shows the version of script"
  echo -e "  ${SCRIPT_NAME} ${COLORS[2]}--cidr-4${COLORS[0]}, ${COLORS[2]}--cidr-ipv4 ${COLORS[0]}shows active interfaces with their IPv4 address and CIDR"
  echo -e "  ${SCRIPT_NAME} ${COLORS[2]}--cidr-6${COLORS[0]}, ${COLORS[2]}--cidr-ipv6 ${COLORS[0]}shows active interfaces with their IPv6 address and CIDR"
  echo -e "  ${SCRIPT_NAME} ${COLORS[2]}--cidr-a${COLORS[0]}, ${COLORS[2]}--cidr-all ${COLORS[0]} shows all information with CIDR"
  echo -e "  ${SCRIPT_NAME} ${COLORS[2]}--cidr-l${COLORS[0]}, ${COLORS[2]}--cidr-list ${COLORS[0]}shows a list of private and reserved IP addresses with CIDR"
  echo -e " options in ${COLORS[2]}green${COLORS[0]} force include ${COLORS[2]}CIDR${COLORS[0]} notation"
  echo -e " options in ${COLORS[1]}red${COLORS[0]} require ${COLORS[1]}ROOT${COLORS[0]} privileges"

  return 0
}

# Prints the right usage of ship -c | --calculate.
function show_usage_ipcalc() {

  echo    " usage:"
  echo -e "  ${SCRIPT_NAME} -c, --calculate <OPTIONS> ${COLORS[5]}192.168.0.1${COLORS[0]}"
  echo -e "  ${SCRIPT_NAME} -c, --calculate <OPTIONS> ${COLORS[5]}192.168.0.1/24${COLORS[0]}"
  echo -e "  ${SCRIPT_NAME} -c, --calculate <OPTIONS> ${COLORS[5]}192.168.0.1 255.255.255.0${COLORS[0]}"
  echo    " options:"
  echo -e "  -b, --nobinary ${COLORS[5]}suppress the bitwise output ${COLORS[0]}"
  echo -e "  -h, --html     ${COLORS[5]}display results as HTML${COLORS[0]}"
  echo -e "  -s, --split    ${COLORS[5]}split into networks of size n1, n2, n3 ${DIALOG_UNDER_DEVELOPMENT}" #TODO
  echo -e "  -r, --range    ${COLORS[5]}deaggregate address range ${DIALOG_UNDER_DEVELOPMENT}" #TODO

  return 0
}

# Starts ship.
function sail() {
  
  [ -z "${1}" ] && error_exit "${DIALOG_ERROR}"

  check_bash_version
  
  while :; do
    case "${1}" in
      "-4"|"--ipv4")
        check_connectivity "--local"
        show_ipv4
        break
        ;;
      "-6"|"--ipv6")
        check_connectivity "--local"
        show_ipv6
        break
        ;;
      "-a"|"--all")
        check_connectivity "--local"
        show_all
        break
        ;;
      "-A"|"--all-interfaces")
        show_all_interfaces
        break
        ;;
      "-c"|"--calculate")
        show_ipcalc "${@:2}"
        break
        ;;
      "-d"|"--driver")
        check_connectivity "--local"
        show_driver
        break
        ;;
      "-e"|"--external")
        check_connectivity "--internet"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_ip_from "${2}"
        shift 2
        break
        ;;
      "-f"|"--find")
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_ips_from_file "${@:2}"
        break
        ;;
      "-g"|"--gateway")
        check_connectivity "--local"
        show_gateway
        break
        ;;
      "-h"|"--help")
        show_usage
        break
        ;;
      "-H"|"--hosts")
        check_connectivity "--local"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_live_hosts "--normal"
        break
        ;;
      "-HM"|"--hosts-mac")
        check_connectivity "--local"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_live_hosts "--mac"
        break
        ;;
      "-i"|"--interfaces")
        check_connectivity "--local"
        show_interfaces
        break
        ;;
      "-l"|"--list")
        show_bogon_ips "--normal"
        break
        ;;
      "-m"|"--mac")
        check_connectivity "--local"
        show_mac
        break
        ;;
      "-n"|"--neighbor")
        check_connectivity "--local"
        show_neighbor_cache
        break
        ;;
      "-P"|"--port")
        check_connectivity "--internet"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_port_connections "${2}"
        shift 2
        break
        ;;
      "-r"|"--route-ipv4")
        check_connectivity "--internet"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_next_hops "--ipv4" "${2}"
        shift 2
        break
        ;;
      "-r6"|"--route-ipv6")
        check_connectivity "--internet"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_next_hops "--ipv6" "${2}"
        shift 2
        break
        ;;
      "-u"|"--url")
        check_connectivity "--internet"
        trap trap_handler INT &>/dev/null
        trap trap_handler SIGTSTP &>/dev/null
        show_ips_from_online_documents "${@:2}"
        break
        ;;
      "-v"|"--version")
        show_version
        break
        ;;
      "--cidr-4"|"--cidr-ipv4")
        check_connectivity "--local"
        show_ipv4_cidr
        break
        ;;
      "--cidr-6"|"--cidr-ipv6")
        check_connectivity "--local"
        show_ipv6_cidr
        break
        ;;
      "--cidr-a"|"--cidr-all")
        check_connectivity "--local"
        show_all_cidr
        break
        ;;
      "--cidr-l"|"--cidr-list")
        show_bogon_ips "--cidr"
        break
        ;;
      *)
        error_exit "${DIALOG_ERROR}" "${1}"
        ;;
    esac
  done

  mr_proper && trap mr_proper EXIT
  exit 0
}

sail "${1+${@}}"
