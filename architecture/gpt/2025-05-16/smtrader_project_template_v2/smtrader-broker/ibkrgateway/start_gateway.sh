#!/bin/bash

# Example shell script to start IBKR Gateway. You need to replace this with your actual IBKR Gateway startup commands.

# Make sure the script is executable:
## chmod +x scripts/start_ibkr_gateway.sh

USERNAME=$1
PASSWORD=$2

echo "Starting IBKR Gateway with user $USERNAME"

# Example: run gateway executable (replace with your actual commands)
/opt/ibkr/ibgateway start --user $USERNAME --password $PASSWORD

# Keep the script running to keep gateway alive
tail -f /dev/null
