#!/bin/bash
################################################################################
#                                                                              #
#                     Chippewa Limited Liability Co.                           #
#                                                                              #
#                                                                              #
#                      Script Name: Detect Addigy MDM Profile                  #
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
# This script checks if the Addigy MDM SSL profile is installed and
# reports the result in a Jamf Pro Extension Attribute.
################################################################################
if profiles -Lv | grep -q "addigy.mdm.ssl"; then
	# If the Addigy MDM SSL profile is installed, report it in the result tag
	/usr/bin/printf "<result>TRUE</result>"
else
	# If the Addigy MDM SSL profile is not installed, report it in the result tag
	/usr/bin/printf "<result>FALSE</result>"
fi
