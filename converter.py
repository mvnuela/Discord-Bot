from Database import Database

class converter:
    def __init__(self, d):
        self.data = d

    def ics(self, data):
        x = data.replace("\n", "")
        icsList = x.split("BEGIN:VEVENT")
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

            ts1 = timeStart1[0] + timeStart1[1]
            intts1 = int(ts1) + 2
            strts1 = str(intts1)
            if intts1 < 10:
                strts1 = '0' + strts1
            timeStart1List = list(timeStart1)
            strts1List = list(strts1)
            timeStart1List[0] = strts1List[0]
            timeStart1List[1] = strts1List[1]
            timeStart1Print = "".join(timeStart1List)

            ts2 = timeEnd1[0] + timeEnd1[1]
            intts2 = int(ts2) + 2
            strts2 = str(intts2)
            if intts2 < 10:
                strts2 = '0' + strts2
            timeEnd1List = list(timeEnd1)
            strts2List = list(strts2)
            timeEnd1List[0] = strts2List[0]
            timeEnd1List[1] = strts2List[1]
            timeEnd1Print = "".join(timeEnd1List)
            print(lesson + "|" + date1 + "|" + timeStart1Print + "|" + timeEnd1Print + "|" + location)

            newinstance.addClasseswithUser( lesson, date1, timeStart1Print, timeEnd1Print, location)















