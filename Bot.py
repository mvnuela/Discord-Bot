import discord
from discord import channel
from discord.ext import commands
from MyEvent import MyEvent
from csv_ical import Convert

# csv_ical ma niby ładnie konwertować do csva


TOKEN="OTExMzQ3Mzk0MjU0MzQwMTI3.YZgEZg.uGCZhDpqjURs5BjapiZCxhY7awM"
#prefixdo wywolania bota
eventBot=commands.Bot(command_prefix='$')

@eventBot.event
async def on_ready():
    print('Connected to bot: {}'.format(eventBot.user.name))
    print('Bot ID: {}'.format(eventBot.user.id))
@eventBot.command()
async def addEvent(ctx,name,date,time,place):
    newEvent=MyEvent(name,date,time,place)
    if(newEvent.addToDB()):
        await ctx.send('Dodano wydarzenie '+name+" "+date+" "+time+ " "+place)
    else:
        await ctx.send("Nie udało się dodać wydarzenia")
@eventBot.command()
async def calendar(ctx):
    if ctx.message.attachments[0].filename.endswith(".ics"):
        fil=None
        name=ctx.message.attachments[0].filename
        data = await ctx.message.attachments[0].read() #tutaj jest zapisany content icsa

@eventBot.command()
async def deleteEvent(ctx,name,date,time,place):
    newEvent = MyEvent(name, date, time, place)
    if (newEvent.deleteFromDB()):
        await ctx.send('Usunięto wydarzenie '+name+" "+date+" "+time + " " +place)
    else:
        await ctx.send('Wskazane wydarzenie nie znajduje sie w bazie')


eventBot.run(TOKEN)
