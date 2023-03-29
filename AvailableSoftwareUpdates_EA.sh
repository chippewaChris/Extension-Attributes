#!/bin/zsh
################################################################################
#                                                                              #
#                     Chippewa Limited Liability Co.                           #
#                                                                              #
#                                                                              #
#                      Script Name: Available Software Updates EA              #
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
# This script uses the softwareupdate binary to get available software updates and
# populates the results as a multiline string to a Jamf Pro Extension Attribute.
################################################################################
# Get available software updates
RESULT=$(/usr/sbin/softwareupdate -l | grep "Label: " | sed 's/^.\{9\}//')

if [ -n "$RESULT" ]; then
  # If there are updates available, populate the EA with multiline results
  /usr/bin/printf "<result>$RESULT</result>"
else
  # If there are no updates available, report it in the result tag
  /usr/bin/printf "<result>No software updates available</result>"
fi