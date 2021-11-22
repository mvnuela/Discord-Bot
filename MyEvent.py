from Database import Database
class MyEvent:
    def __init__(self,n,dat,ti,pl):
        self.name=n
        self.date=dat
        self.place=pl
        self.time = ti

    def addToDB(self):
        newinstance = Database()
        return newinstance.addEvent(self.name,self.date,self.time,self.place)

    def deleteFromDB(self):
        newinstance = Database()
        return newinstance.rmEvent(self.name, self.date,self.time, self.place)
