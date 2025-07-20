#!/bin/bash
# This script is the main engine for the research agent.
# It is called by the YAML workflow.

# Exit immediately if any command fails
set -e

# --- ROBUSTNESS FIX ---
# Use a variable to find the directory where this script is located.
# This makes the file paths more reliable.
SCRIPT_DIR=$(dirname "$0")

# The topic is passed as the first argument from the workflow
TOPIC="$1"
PROMPT_FILE="$SCRIPT_DIR/prompt.txt" # Use the SCRIPT_DIR variable

echo "--- Starting research for topic: $TOPIC ---"

# Check if the prompt file exists
if [ ! -f "$PROMPT_FILE" ]; then
  echo "Error: Prompt file not found at $PROMPT_FILE"
  exit 1
fi

# Read the prompt template and replace the placeholder with the real topic
PROMPT_TEMPLATE=$(cat "$PROMPT_FILE")
PROMPT="${PROMPT_TEMPLATE//'{TOPIC}'/$TOPIC}"

# Use jq to safely create the JSON payload for the API
JSON_PAYLOAD=$(jq -n --arg prompt "$PROMPT" \
  '{contents: [{parts: [{text: $prompt}]}]}')

echo "--- Calling Gemini API ---"

# Call the API using the secret key, which is passed as an environment variable
API_RESPONSE=$(curl -s -X POST "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${GEMINI_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD")

# Extract the report text using jq.
REPORT_TEXT=$(echo "$API_RESPONSE" | jq -r '.candidates[0].content.parts[0].text')

# A crucial check: If the API response was an error, the text will be "null" or empty
if [ -z "$REPORT_TEXT" ] || [ "$REPORT_TEXT" == "null" ]; then
  echo "Error: Failed to extract a valid report from the API response."
  echo "Full API Response was:"
  echo "$API_RESPONSE"
  exit 1
fi

# Print the final report to the logs
echo "--- GENERATED REPORT START ---"
echo "$REPORT_TEXT"
echo "--- GENERATED REPORT END ---"
