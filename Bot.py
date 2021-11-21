import discord
from discord.ext import commands
from MyEvent import MyEvent

TOKEN="OTExMzQ3Mzk0MjU0MzQwMTI3.YZgEZg.uGCZhDpqjURs5BjapiZCxhY7awM"
#prefixdo wywolania bota
eventBot=commands.Bot(command_prefix='$')

@eventBot.event
async def on_ready():
    print('Connected to bot: {}'.format(eventBot.user.name))
    print('Bot ID: {}'.format(eventBot.user.id))
@eventBot.command()
async def addEvent(ctx,name,category,data):
    newEvent=MyEvent(name,category,data)
    newEvent.addToDB()
    await ctx.send('Dodano wydarzenie '+name+" "+category+" "+data)
@eventBot.command()

async def deleteEvent(ctx,name,category,data):
    await ctx.send('Usunięto wydarzenie '+name+" "+category+" "+data)

eventBot.run(TOKEN)
