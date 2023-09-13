#!/bin/bash

# Define the API endpoint URL
URL="https://sandyhs.goalexandria.com/api/search2/find"

# Initialize an array to keep track of unique book titles
declare -A uniqueBooks

# Function to send a request and update unique book titles
function sendRequestAndUpdateUniqueBooks {
  local letter="$1"
  local page=1

  while true; do
    local json_data='{
      "search": "(((smart::'$letter'*)) && ((sitersn::'$page') || (site::KNOCOPY)) && (hidetitle::0))",
      "sessionid": "30F2E4A8D20848B887C82F7EFFC45DB0",
      "allSites": false,
      "hideOut": true,
      "maxHits": 100000,
      "requestingApplication": 1936869700
    }'

    local response=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data" "$URL")

    # Check if there are items in the response
    if [ -n "$response" ]; then
      local titles=($(echo "$response" | jq -r '.items[].title'))
      for title in "${titles[@]}"; do
        uniqueBooks["$title"]=1
      done

      # Check if there are more pages of results
      local fullCount=$(echo "$response" | jq -r '.fullCount')
      local pageCount=$(echo "$response" | jq -r '.items | length')

      if (( pageCount < fullCount )); then
        ((page++))
      else
        break
      fi
    else
      break
    fi
  done
}

# Iterate through the alphabet and send requests
for letter in {A..Z}; do
  sendRequestAndUpdateUniqueBooks "$letter"
done

# Count the total number of unique books
totalUniqueBooks=${#uniqueBooks[@]}

echo "Total number of unique books: $totalUniqueBooks"

