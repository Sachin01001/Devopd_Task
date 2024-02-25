#!/bin/bash

# Function to ping a node and log the result
ping_node() {
    # Get node address as argument
    node=$1
    # Get current timestamp
    timestamp=$(date +"%Y-%m-%d %T")
    # Ping the node once
    if ping -c 1 "$node" &> /dev/null; then
        # If ping is successful, print and log reachable status
        echo "$timestamp $node is reachable"
        echo "$timestamp $node is reachable" >> network_monitor_log.txt
    else
        # If ping fails, print and log unreachable status, then send email notification
        echo "$timestamp $node is unreachable"
        echo "$timestamp $node is unreachable" >> network_monitor_log.txt
        send_email_notification "$node"
    fi
}

# Function to send email notification
send_email_notification() {
    # Get node address as argument
    node=$1
    # Print notification about sending email
    echo "Sending email notification for $node being unreachable..."
    # Modify the following line with your email subject, recipient address, and sender address
    # Send email notification about unreachable node
    echo "Node $node is unreachable. Please check." | mail -s "Node $node is unreachable" your@gmail.com
}

# Main function
main() {
    # Check if no arguments are provided
    if [ $# -eq 0 ]; then
        # Print usage instructions and exit if no arguments are provided
        echo "Usage: $0 [node1] [node2] ..."
        exit 1
    fi

    # Check if ping_log.txt exists, if not create it
    touch ping_log.txt

    # Loop through each node and ping it
    for node in "$@"; do
        ping_node "$node"
    done
}

# Execute main function with provided arguments
main "$@"
