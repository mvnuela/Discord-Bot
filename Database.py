import copy
import time

import mysql.connector
from mysql.connector import Error
from datetime import date, timedelta, datetime

class Database:
    def __init__(self):
        self.conn = None
        try:
            self.conn = mysql.connector.connect(host='localhost',
                                           database='discordbot',
                                           user='BotUser',
                                           password='123')
            if self.conn.is_connected():
                print('Connected to MySQL database')

        except Error as e:
            print('Cannot connected to MySQL database')
            print(e)
    def addEvent(self,name,date,time,place):
        succes = 1
        query = "INSERT INTO events(Name,Date,Time,Place) " \
                "VALUES(%s,%s,%s,%s)"
        args = (name, date,time,place)

        try:
          #  db_config = read_db_config()
          #  conn = MySQLConnection(**db_config)

            cursor = self.conn.cursor()
            cursor.execute(query, args)

            if cursor.lastrowid:
                print('last insert id', cursor.lastrowid)
            else:
                print('last insert id not found')

            self.conn.commit()
            print("Added to database")
        except Error as error:
            print(error)
            print("Cannot add to database")
            succes = 0

        finally:
            cursor.close()
            self.conn.close()
            return succes
    def rmEvent(self,name,date,time,place):
        succes = 1
        query = "DELETE FROM events  WHERE Name = %s AND Date =%s " \
                "AND Time = %s AND Place =%s"
        args = (name, date, time, place)

        try:
            cursor = self.conn.cursor()
            cursor.execute(query, args)

            if cursor.lastrowid:
                print('last insert id', cursor.lastrowid)
            else:
                print('last insert id not found')

            self.conn.commit()
            print("Deleted from database")
        except Error as error:
            print(error)
            print("Cannot delete from database")
            succes = 0

        finally:
            cursor.close()
            self.conn.close()
            return succes
    def getEvents(self,firstDate,lastDate):
        query = "SELECT Name, Date, Time, Place FROM events  WHERE Date >= %s AND Date <= %s"
        args = (firstDate,lastDate)

        try:

            cursor = self.conn.cursor(True)
            cursor.execute(query, args)
            self.conn.commit()
            print("Get from database")
            ans = list(cursor.fetchall())
        except Error as error:
            print(error)
            print("Something wrong")

        finally:
            cursor.close()
            self.conn.close()
            return ans

    def getDay(self, day, Id):
        try:

            cursor = self.conn.cursor(True)
            cursor.callproc('showDay', [day,Id, ])
            self.conn.commit()
            print("Get from database")
            #ans = list(cursor.fetchall())
            ans = list()
            for result in cursor.stored_results():


                ans.append(result.fetchall())
        except Error as error:
            print(error)
            print("Something wrong")

        finally:
            cursor.close()
            self.conn.close()
            return ans

        pass

    def getWeekd(self, day, Id):
        try:

            cursor = self.conn.cursor(True)
            cursor.callproc('showWeek', [day,Id, ])
            self.conn.commit()
            print("Get from database")
            ans = list()
            for result in cursor.stored_results():
                ans.append(result.fetchall())
        except Error as error:
            print(error)
            print("Something wrong")

        finally:
            cursor.close()
            self.conn.close()
            return ans
        pass

    def getFreeDays(self, firstDate, lastDate, Id):
        try:

            cursor = self.conn.cursor(True)
            cursor.callproc('showDaysWithClasses', [firstDate, lastDate, Id ])
            self.conn.commit()
            print("Get from database")
            ans = list()
            for result in cursor.stored_results():
                ans.append(result.fetchall())

            alldays = list()
            start_date = date.fromisoformat(firstDate)
            end_date = date.fromisoformat(lastDate)
            delta = end_date - start_date

            for i in range(delta.days + 1):
                day = start_date + timedelta(days=i)
                alldays.append(day)

            print(alldays)
            for i in range(len(alldays)):
                print(alldays[i])

            takendays = list()
            for i in range(len(ans[0])):
                takendays.append(ans[0][i][0])

            print("takendays")
            for i in range(len(takendays)):
                print(takendays[i])

            freeDays = list(set(alldays) - set(takendays))
            freeDays.sort()
            fDays = ''
            for i in range(len(freeDays)):
                print(freeDays[i])
                fDays += freeDays[i].strftime("%Y-%m-%d")
                fDays += "\n"
            print("freeDays")
            print(fDays)

        except Error as error:
            print(error)
            print("Something wrong")

        finally:
            cursor.close()
            self.conn.close()
            return fDays
        pass

    def getFreeTime(self, day, Id):
        try:

            cursor = self.conn.cursor(True)
            cursor.callproc('showWeek', [day,Id, ])
            self.conn.commit()
            print("Get from database")
            ans = list()
            for result in cursor.stored_results():
                ans.append(result.fetchall())

            takentime = list()
            for i in range(len(ans[0])):
                takentime.append(ans[0][i])

            #adding nights
            for x in range(7):
                night = list()
                d = date.fromisoformat(day)
                d += timedelta(days=x)
                start_night = timedelta(seconds=82800)
                end_night = timedelta(seconds=28800)
                night = ('spanko',d,start_night,end_night,'śpiulkolot')
                takentime.append(night)

            takentime = sorted(takentime, key=lambda x: (x[1], x[2]))
            print("takentime with nights")
            for i in range(len(takentime)):
                print(takentime[i])

            #setting pointers of timeslot
            start = [date.fromisoformat(day), timedelta(seconds=32400)]
            end = copy.deepcopy(start)

            k = 0 #pointer on timeoccupied in takentime
            timeSlots = list()
            while (end[0] <= (date.fromisoformat(day)+timedelta(days=6))) & (end[1] <= start_night):
                if (start[1] >= takentime[k][2]) & (start[1] <= takentime[k][3]):
                    print("in")
                    start[1] = takentime[k][3]
                    k += 1
                    end[0] = takentime[k][1]
                    end[1] = takentime[k][2]
                    print("start")
                    print(start)
                    print("end")
                    print(end)
                elif start[1] < takentime[k][2]:
                    print("before")
                    print(takentime[k][2])
                    end[1] = takentime[k][2]
                    print("start")
                    print(start)
                    print("end")
                    print(end)
                else:
                    print("after")
                    k += 1
                    end[0] = takentime[k][1]
                    end[1] = takentime[k][2]
                    print("start")
                    print(start)
                    print("end")
                    print(end)

                print("start")
                print(start)
                print("end")
                print(end)
                print("adding slot: ")
                #sprawdź długość slota
                print(takentime[k][1], start[1], end[1])
                timeSlot = [takentime[k][1], start[1], end[1]]
                timeSlots.append(timeSlot)
                if takentime[k][2] > takentime[k][3]:
                    start[0] = takentime[k][1] + timedelta(days=1)
                else:
                    start[0] = takentime[k][1]
                start[1] = takentime[k][3]
                end = copy.deepcopy(start)
                k += 1

            fTime = ''
            for i in range(len(timeSlots)):
                print(timeSlots[i])
                fTime += timeSlots[i][0].strftime("%Y-%m-%d") + " " + str(timeSlots[i][1]) + " " + str(timeSlots[i][2])
                fTime += "\n"

        except Error as error:
            print(error)
            print("Something wrong")

        finally:
            cursor.close()
            self.conn.close()
            return fTime
        pass

    def addClasses(self, lesson, date, timeStart, timeEnd, place):
        succes = 1
        query = "INSERT INTO classes(Name,Date,TimeStart,TimeEnd,Place) " \
                "VALUES(%s,%s,%s,%s,%s)"
        args = (lesson, date, timeStart, timeEnd, place)

        try:
          #  db_config = read_db_config()
          #  conn = MySQLConnection(**db_config)

            cursor = self.conn.cursor()
            cursor.execute(query, args)

            if cursor.lastrowid:
                print('last insert id', cursor.lastrowid)
            else:
                print('last insert id not found')

            self.conn.commit()
            print("Added to database")
        except Error as error:
            print(error)
            print("Cannot add to database")
            succes = 0

        finally:
            cursor.close()
            self.conn.close()
            return succes
