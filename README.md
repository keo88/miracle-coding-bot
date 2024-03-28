# Miracle Coding Bot
This project aims to automate tasks in a group study session for coding test. A Discord bot automatically sends a formatted message on discord server, whenever someone commits their newly solved PS solution on certain git repository.

## Features
- Execute run.sh, and the bot will detect newly solved coding test problems in the desginated local git repository and send messages on discord servers.

## Installation
1. Fill in the details in .env.example. You will need **discord bot token** and **git repository path**(A git repo where you keep your coding test solutions).
2. Change the file name from `.env.example` to `.env`
3. Add your discord bot to servers. Make sure to change or create text channels that has 'git' or 'leetcode' in their name.
4. Execute run.sh with problem url.
```sh
run.sh "[htt](https://leetcode.com/problems/maximum-subarray)"
```
5. (Optional) Add post-commit git hook to your local repo. This way the bot will automatically sends messages without having to call run.sh all the time.
```sh
#!/bin/sh
# Example post-commit git hook

exec < /dev/tty
read -p 'Enter problem URL: ' url

# Activate the virtual environment
. /path/to/your/venv/activate

# Change directory to the project directory
cd /path/to/this/project/miracle-coding-bot || exit

# Run the script
./run.sh "$url"
```
