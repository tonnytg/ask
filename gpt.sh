#!/bin/bash

export OPENAI_API_KEY="abcdefg123456"

#CallGPT will get information from API on OpenAI API for ChatGPT
function CallGPT() {
    # Check Token
    if [[ -z "$OPENAI_API_KEY" ]]; then
        echo "Error: OPENAI_API_KEY failed"
        exit 1
    fi

    # Check message to ask
    if [[ -z "$1" ]]; then
        echo "Uso: $0 \"Your message ChatGPT\""
        exit 1
    fi

    # Call the API
    response=$(curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "{
            \"model\": \"gpt-4\",
            \"messages\": [
                {\"role\": \"user\", \"content\": \"$1\"}
            ]
        }")

    # Print the message
    echo "$response" | jq -r '.choices[0].message.content'
}

# Call function
CallGPT "$1"

