#!/bin/bash
################################################################################
#                                                                              #
#                     Chippewa Limited Liability Co.                           #
#                                                                              #
#                                                                              #
#                      Script Name: Customer Field Extension Atttribute        #
#                      Version: 1.0, 3/22/23                                   #
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

# Run checkjssconnection to get the JSS URL
checkjss_output=$(jamf checkjssconnection)

# Extract the JSS URL from the output
jss_url=$(echo "$checkjss_output" | sed -n -e 's/^Checking availability of \(.*\)...$/\1/p')

# Extract the customer name from the JSS URL
customer=$(echo "$jss_url" | awk -F'/' '{print $3}' | sed -e 's/\.jamfcloud\.com$//')

# Set the Extension Attribute value in the result tags
echo "<result>$customer</result>"
