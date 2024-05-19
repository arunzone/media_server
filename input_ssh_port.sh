#!/bin/bash

min_value="49152"
max_value="65535"

# Function to validate user input port number
function validate_number() {
  local ssh_port_number="$1"

  # Check if input is a number
  if ! [[ "$ssh_port_number" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a number."
    return 1
  fi

  # Check if number is within range
  if [[ "$ssh_port_number" -lt "$min_value" || "$number" -gt "$max_value" ]]; then
    echo "Error: Number must be between $min_value and $max_value."
    return 1
  fi

  return 0  # Valid number
}

# Loop until valid input is received
while true; do
  read -p "Enter a ssh port number to create between $min_value and $max_value: " ssh_port_number

  # Validate the input
  if validate_number "$ssh_port_number"; then
    break  # Exit loop if validation successful
  fi
done

echo "You entered: $ssh_port_number"

# Use the validated number here (e.g., assign to a variable)


