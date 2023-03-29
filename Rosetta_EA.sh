#!/bin/zsh


# Check if Mac is running on Intel or Apple Silicon
processor=$(uname -m)
if [ "$processor" == "x86_64" ]; then
  # Mac is running on Intel processor
  echo "<result>Intel</result>"
  exit 0
elif [ "$processor" == "arm64" ]; then
  # Mac is running on Apple Silicon
  # Check if Rosetta is installed
  rosetta=$(/usr/sbin/pkgutil --pkgs='com.apple.pkg.RosettaUpdateAuto' 2>/dev/null)
  if [[ "$rosetta" == "com.apple.pkg.RosettaUpdateAuto" ]]; then
    echo "<result>Apple Silicon with Rosetta</result>"
    exit 0
  else
    echo "<result>Apple Silicon without Rosetta</result>"
    exit 0
  fi
else
  # Unknown processor architecture
  echo "<result>Unknown processor architecture</result>"
  exit 1
fi

