class MyEvent:
    def __init__(self,n,cat,dat):
        self.name=n
        self.category=cat
        self.data=dat

    def addToDB(self):
        print("Dodano do bazy")
    def deleteFromDB(self):
        print("Usunieto z bazy")