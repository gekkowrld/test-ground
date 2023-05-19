#!/bin/bash

echo -e "Please enter your token. \n The minimum required scopes are 'repo', 'read:org', 'admin:public_key'"
read token

if ! command -v curl; then
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
fi

if ! command -v gh; then
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

	else
		sudo apt update && sudo apt install gh -y
fi

echo "$token" > token.txt

gh auth login --with-token < token.txt

rm token.txt