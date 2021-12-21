from Database import Database

class converter:
    def __init__(self, d):
        self.data = d

    def ics(self, data):
        icsList = data.split("BEGIN:VEVENT")
        for i in range(1, len(icsList)):
            newinstance = Database()
            x = icsList[i]
            datePosition1 = x.find("DTSTART:") + 8
            datePosition2 = datePosition1 + 8
            date = x[datePosition1:datePosition2]
            date1 = date[0:4] + '-' + date[4:6] + '-' + date[6:8]
            timeStartPosition1 = datePosition2 + 1
            timeStartPosition2 = timeStartPosition1 + 6
            timeStart = x[timeStartPosition1:timeStartPosition2]
            timeStart1 = timeStart[0:2] + ':' + timeStart[2:4] + ':' + timeStart[4:6]
            timeEndPosition1 = x.find("DTEND:") + 15
            timeEndPosition2 = timeEndPosition1 + 6
            timeEnd = x[timeEndPosition1:timeEndPosition2]
            timeEnd1 = timeEnd[0:2] + ':' + timeEnd[2:4] + ':' + timeEnd[4:6]
            locationPosition1 = x.find("LOCATION:") + 9
            locationPosition2 = x.find("SEQUENCE:")
            location = x[locationPosition1:locationPosition2]
            summaryPosition1 = x.find("SUMMARY:") + 9
            summaryPosition2 = x.find("TRANSP:") + 1
            lesson = x[summaryPosition1:summaryPosition2]

            newinstance.addClasses( lesson, date1, timeStart1, timeEnd1, location)















