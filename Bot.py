import discord
from discord import channel
from discord.ext import commands

from Database import Database
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
async def showEvents(ctx, firstDate, lastDate):
    newinstance = Database()
    Events =newinstance.getEvents(firstDate,lastDate)
    for e in Events:
        await ctx.send(e[0] + " " + e[1].strftime("%Y-%m-%d") + " " +str(e[2]) + " " +e[3])

@eventBot.command()
async def deleteEvent(ctx,name,date,time,place):
    newEvent = MyEvent(name, date, time, place)
    if (newEvent.deleteFromDB()):
        await ctx.send('Usunięto wydarzenie '+name+" "+date+" "+time + " " +place)
    else:
        await ctx.send('Wskazane wydarzenie nie znajduje sie w bazie')

@eventBot.command()
async def showDay(ctx,day,Id):
    newinstance = Database()
    Events = newinstance.getDay(day,Id)
    for e in Events[0]:
        await ctx.send(e[0] + " " + e[1].strftime("%Y-%m-%d") + " " + str(e[2]) + " " + str(e[3])
                       + " " + e[4] + " " + e[5])
@eventBot.command()
async def showWeek(ctx,day,Id):
    newinstance = Database()
    Events = newinstance.getWeekd(day,Id)
    for e in Events[0]:
        await ctx.send(e[0] + " " + e[1].strftime("%Y-%m-%d") + " " + str(e[2]) + " " + str(e[3])
                       + " " + e[4] + " " + e[5])




eventBot.run(TOKEN)
