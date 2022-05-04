public class CalendarExample_Controller {
        public Boolean includeMyEvents {get;set;}
    public list<calEvent> events {get;set;}    

    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly
    String dtFormat = 'yyyy-MM-dd HH:mm:ss';

    //constructor
    public CalendarExample_Controller() {
        //Default showing my events to on
        includeMyEvents = true;
    }

    public PageReference pageLoad() {
        events = new list<calEvent>();
        //Get my Events if we have selected the correct option
        if(includeMyEvents){
            List<Account> accountActivities=
                [select Name,(select Id,subject,IsAllDayEvent,StartDateTime, EndDateTime from OpenActivities),
                 (select Id,subject,IsAllDayEvent,StartDateTime, EndDateTime from ActivityHistories) from Account];
            for(Account acc:accountActivities){
                for(OpenActivity openAct:acc.OpenActivities){
                    DateTime startDT = openAct.StartDateTime;
                        DateTime endDT = openAct.EndDateTime;
                        calEvent myEvent = new calEvent();
                        myEvent.title = openAct.Subject+'-'+acc.Name;
                        myEvent.allDay = openAct.isAllDayEvent; 
                        myEvent.startString = startDT.format(dtFormat);
                        myEvent.endString = endDT.format(dtFormat);
                        myEvent.url = '/' + openAct.Id;
                        myEvent.className = 'event-personal';
                        events.add(myEvent);
                }
                for(ActivityHistory actHist:acc.ActivityHistories){
                    DateTime startDT = actHist.StartDateTime;
                        DateTime endDT = actHist.EndDateTime;
                        calEvent myEvent = new calEvent();
                        myEvent.title = actHist.Subject+'-'+acc.Name;
                        myEvent.allDay = actHist.isAllDayEvent; 
                        myEvent.startString = startDT.format(dtFormat);
                        myEvent.endString = endDT.format(dtFormat);
                        myEvent.url = '/' + actHist.Id;
                        myEvent.className = 'event-personal';
                        events.add(myEvent);
                }
            }
                }
        return null;
    }
    
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
    
    //Class to hold calendar event data
    public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;private set;}
        public String endString {get;private set;}
        public String url {get;set;}
        public String className {get;set;}
    }
}