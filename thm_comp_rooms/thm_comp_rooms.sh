#!/bin/bash
# A script to display the titles and difficulty of the completed rooms on TryHackMe
# dependencies: jq
# usage ./thm_comp_rooms.sh

# Set the intended pagination limit
API_LIMIT=100

echo -n "Enter your TryHackMe username: "
read USERNAME

# --- 1. Fetch User ID and Error Check ---
# Fetches the User ID (e.g., 6xxxxxxxxxxxxxxxxxP) using the public-profile endpoint.
USER_ID=$(curl -s "https://tryhackme.com/api/v2/public-profile?username=${USERNAME}" -H 'User-Agent: Mozilla/5.0' | jq -r '.data._id')

# Exit if the User ID is not found (e.g., bad username or API failure)
if [ -z "$USER_ID" ] || [ "$USER_ID" = "null" ]; then
    echo "ERROR: User ID for '${USERNAME}' not found. Please check the username and try again." >&2
    exit 1
fi

# --- 2. Fetch Metadata (Total Count & Total Pages) ---

# Fetch metadata using the correct API_LIMIT (100) to get the accurate totalPages count.
METADATA=$(curl -s "https://tryhackme.com/api/v2/public-profile/completed-rooms?user=${USER_ID}&limit=${API_LIMIT}&page=1")

# Extract metadata
NUM_ROOMS=$(echo "$METADATA" | jq -r '.data.totalDocs')
TOTAL_PAGES=$(echo "$METADATA" | jq -r '.data.totalPages')

# Exit if no rooms are completed
if [ "$NUM_ROOMS" = "0" ] || [ -z "$NUM_ROOMS" ]; then
    echo -e "\n${USERNAME} has not completed any rooms or the API request failed."
    exit 0
fi

echo -e "\n${USERNAME} has completed ${NUM_ROOMS} rooms across ${TOTAL_PAGES} page(s).\n"
echo "--- ROOMS COMPLETED ---"

# --- 3. API-Driven Pagination Loop ---

PAGE=1
while [ "$PAGE" -le "$TOTAL_PAGES" ]; do

    # Calculate the starting number for the 'nl' command.
    START_NUM=$(( (PAGE - 1) * API_LIMIT + 1 ))

    # Fetch the current page data, format it, and print with the correct numbering.
    curl -s "https://tryhackme.com/api/v2/public-profile/completed-rooms?user=${USER_ID}&limit=${API_LIMIT}&page=${PAGE}" \
    | jq -r '.data.docs[] | "\(.title) (\(.difficulty))"' | nl -v $START_NUM -w 3 -s ". "

    ((PAGE++))
done
