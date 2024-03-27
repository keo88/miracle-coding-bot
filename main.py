import asyncio

import discord
from discord.ext import commands
import sys
import os
from dotenv import load_dotenv

load_dotenv()

intents = discord.Intents.all()
bot = commands.Bot(command_prefix='$', intents=intents)
token = os.environ.get('DISCORD_BOT_TOKEN')
arg_message_content = ''

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')
    git_channels = []
    for guild in bot.guilds:
        for channel in guild.text_channels:
            if channel.name.find('git') != -1:
                git_channels.append(channel)

    await send_message_to_discord(arg_message_content, git_channels[0] if len(git_channels) > 0 else None)
    await bot.close()


async def send_message_to_discord(message_content, channel=None):
    print(message_content)
    if channel:
        await channel.send(message_content)
    else:
        print("Channel not found.")


# @bot.command()
# async def sendmessage(ctx, message_content):
#     await send_message_to_discord(message_content)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python send_discord_message.py <message_content>")
        sys.exit(1)
    arg_message_content = " ".join(sys.argv[1:])

bot.run(token)