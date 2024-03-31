#!/bin/bash
set -e  # Exit on any error
set -x  # Print each command before executing

# Forzar la ejecución del script de configuración sin verificar config.json
echo "Executing setup"
/opt/cronicle/bin/control.sh setup || true

# Here you can include additional setup commands if necessary

# Now that setup has completed, we need to wait a bit before starting
echo "Waiting for Cronicle setup to finalize..."
sleep 20 # wait for 70 seconds; adjust this as needed

# Make sure the log file exists and tail it in the background
# This will keep the process in the foreground, so Docker knows the container is still active
touch /opt/cronicle/logs/cronicle.log
tail -f /opt/cronicle/logs/cronicle.log &

# Start Cronicle using the control script
echo "Starting Cronicle..."
/opt/cronicle/bin/control.sh start

# Capture the PID of the Cronicle process
CRONICLE_PID=$!
wait $CRONICLE_PID
