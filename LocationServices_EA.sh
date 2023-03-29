#!/bin/bash
################################################################################
#                                                                              #
#                     Chippewa Limited Liability Co.                           #
#                                                                              #
#                                                                              #
#                      Script Name:LocationServices State                      #
#                      Version: 1.0, 3/17/23                                   #
#                                                                              #
################################################################################
#
# Author
# Chris Cohoon | Chippewa Limited Liability Co.
#
# License Grant and Restrictions
# This script (the "Work") is licensed to Parachute Inc. (the "Licensee") for use
# in their internal business operations only. The Licensee is granted a
# non-exclusive, non-transferable, and non-assignable license to use the Work for
# lawful purposes only, and may not modify, reverse engineer, decompile, or
# disassemble the Work without prior written consent from Chippewa Limited
# Liability Co.
#
# Ownership and Warranty
# Chippewa Limited Liability Co. retains all ownership and intellectual property
# rights in the Work. The Work is provided "AS IS" without warranty of any kind,
# express or implied.
#
# All rights reserved 2023 Chippewa Limited Liability Co.
#
################################################################################
# Use the 'defaults' command to read the value of the 'LocationServicesEnabled'
# key from the ByHost preferences domain for the location daemon. Store the
# output in the 'LocationServices' variable.
################################################################################
# Get the macOS version number
MACOS_VERSION=$(sw_vers -productVersion | awk -F '.' '{print $1}')

# Check if the macOS version is 13 (Ventura)
if [ "${MACOS_VERSION}" -eq 13 ]; then
	# Get the UUID of the com.apple.locationd plist file
	UUID=$(ls /var/db/locationd/Library/Preferences/ByHost | grep -E "^com\.apple\.locationd\.[[:xdigit:]]{8}-([[:xdigit:]]{4}-){3}[[:xdigit:]]{12}\.plist$" | awk -F '.' '{print $4}')
	
	# Check if the UUID is empty
	if [ -z "${UUID}" ]; then
		echo "<result>Unable to determine UUID of com.apple.locationd.plist file.</result>"
		exit 0
	fi
	
	# Read the LocationServicesEnabled key from the plist file
	LOCATION_SERVICES_ENABLED=$(/usr/libexec/PlistBuddy -c "Print :LocationServicesEnabled" "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${UUID}.plist")
	
	# Check if the LOCATION_SERVICES_ENABLED variable contains "true" or "false"
	if [ "${LOCATION_SERVICES_ENABLED}" != "true" ] && [ "${LOCATION_SERVICES_ENABLED}" != "false" ]; then
		echo "<result>Cannot determine Location Services on macOS ${MACOS_VERSION}.</result>"
		exit 0
	fi
	
	# Return the LocationServicesEnabled value
	echo "<result>${LOCATION_SERVICES_ENABLED}</result>"
else
	# Get the LocationServicesEnabled value using the defaults command
	LOCATION_SERVICES_ENABLED=$(defaults -currentHost read "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd" LocationServicesEnabled 2>/dev/null)
	
	# Check if the LOCATION_SERVICES_ENABLED variable contains "true" or "false"
	if [ "${LOCATION_SERVICES_ENABLED}" != "true" ] && [ "${LOCATION_SERVICES_ENABLED}" != "false" ]; then
		echo "<result>Cannot determine Location Services on macOS ${MACOS_VERSION}.</result>"
		exit 0
	fi
	
	# Return the LocationServicesEnabled value
	echo "<result>${LOCATION_SERVICES_ENABLED}</result>"
fi
