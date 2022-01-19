import discord
from discord import channel
from discord.ext import commands

from Database import Database
from MyEvent import MyEvent
from converter import converter

#intents = discord.Intents.all()
intents = discord.Intents.default()
intents.members = True
TOKEN="OTExMzQ3Mzk0MjU0MzQwMTI3.YZgEZg.uGCZhDpqjURs5BjapiZCxhY7awM"
#prefixdo wywolania bota
eventBot=commands.Bot(command_prefix='$', intents=intents)

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
        data = await ctx.message.attachments[0].read()
        data1=str(data)
        Con = converter(data1)
        Con.ics(data1) #przerzut do konwersji(w konwersji też jest dodawanie do bazy)

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
    if not Events[0]:
        await ctx.send('Tego dnia nie ma żadnych zajęć.')
    else:
        for e in Events[0]:
            await ctx.send(e[0] + " " + e[1].strftime("%Y-%m-%d") + " " + str(e[2]) + " " + str(e[3])
                       + " " + e[4])
@eventBot.command()
async def showWeek(ctx,day,Id):
    newinstance = Database()
    Events = newinstance.getWeekd(day,Id)
    if not Events[0]:
        await ctx.send('W tym nie ma żadnych zajęć.')
    else:
        for e in Events[0]:
            await ctx.send(e[0] + " " + e[1].strftime("%Y-%m-%d") + " " + str(e[2]) + " " + str(e[3])
                       + " " + e[4])
@eventBot.command()
async def freeDays(ctx, firstDate, lastDate, Id):
    newinstance = Database()
    Events = newinstance.getFreeDays(firstDate, lastDate, Id)
    if not Events:
        await ctx.send('Przykro mi, w tym okresie nie masz dni wolnych :(.')
    else:
        await ctx.send(Events)
@eventBot.command()
async def freeTime(ctx, date, Id):
    newinstance = Database()
    Events = newinstance.getFreeTime(date, Id)
    if not Events:
        await ctx.send('Przykro mi, w tym okresie nie masz czasu wolnego :(.')
    else:
        await ctx.send(Events)

@eventBot.command()
async def message_all(ctx, *, args=None):
    if args !=None:
        channel = eventBot.get_channel(899711418276917309)
        members = channel.guild.members
        print("Lista memberow text")
        #members = ctx.guild.members
        for member in members:
            print(member)
            try:
                await member.send(args)
            except:
                print("Didn't work for this member (maybe member is a bot).")
    else:
        await ctx.send("Please provide an argument!")

@eventBot.command()
async def attach_all(ctx, *, args=None):
    if args !=None:
        channel = eventBot.get_channel(899711418276917309)
        members = channel.guild.members
        print("Lista memberow jpg")
        for member in members:
            print(member)
            try:
                await member.send(file=discord.File(args))
            except:
                print("Didn't work for this member (maybe member is a bot).")
    else:
        await ctx.send("Please provide a filepath!")


eventBot.run(TOKEN)
