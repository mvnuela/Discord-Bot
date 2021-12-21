from Database import Database

class converter:
    def ics(self, data):
        icsList = data.split("BEGIN:VEVENT")
        newinstance = Database()
        for i in range(1, len(icsList)):
            x = icsList[i]
            x.removeprefix("DTSTART:")
            date = x[:8]
            date1 = date[:4] + '-' + date[5:6] + '-' + date[7:8]
            datecut = date + 'T'
            x = x.lstrip(datecut)
            timeStart = x[:6]
            timeStart1 = timeStart[:2] + ':' + timeStart[3:4] + ':' + timeStart[5:6]
            x = x.lstrip(timeStart)
            x.removeprefix("ZDTEND:")
            timeEnd = x[10:15]
            timeEnd1 = timeEnd[:2] + ':' + timeEnd[3:4] + ':' + timeEnd[5:6]
            locationPosition1 = x.find("LOCATION:") + 10
            locationPosition2 = x.find("SEQUENCE:") + 1
            location = x[locationPosition1:locationPosition2]
            summaryPosition1 = x.find("SUMMARY:") + 9
            summaryPosition2 = x.find("TRANSP:") + 1
            lesson = x[summaryPosition1:summaryPosition2]
            if(icsList[i].find("END:VCALENDAR") != -1):
                break
            Database.addClasses(lesson, date1, timeStart1, timeEnd1, location)















