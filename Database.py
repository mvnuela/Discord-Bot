import mysql.connector
from mysql.connector import Error
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
