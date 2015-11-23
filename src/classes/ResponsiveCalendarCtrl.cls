global with sharing class ResponsiveCalendarCtrl{

 public string todaysdate{get;set;}
 
 global ResponsiveCalendarCtrl(){
     todaysdate=system.now().format('yyyy-MM-dd');
 }

   @RemoteAction
    global static list<calendarWrapper> getCalendarItems(string ObjectName,string URL,string startdatetimeField,string enddatetimeField,string title){
       list<calendarWrapper> lstcalendar=new list<calendarWrapper>();
       TimeZone tz = UserInfo.getTimeZone();
       String loggedInUserId = UserInfo.getUserId();
       string querystr='Select Id'+','+title+','+enddatetimeField+','+startdatetimeField;
       if(URL!='id'){
         querystr=querystr+','+URL;
       }
       querystr=querystr+' from '+ObjectName+'where ownerId=:loggedInUserId'+' order by createdDate DESC limit 25000';//Limit the data
       for(Sobject t:Database.query(querystr)){
           calendarWrapper c=new calendarWrapper();
           c.title=(string)t.get(title);
           c.Id=(string)t.get(URL);
           if(startdatetimeField !=null){
             if(t.get(startdatetimeField)!=null){
                c.start=((datetime)t.get(startdatetimeField)).gettime()+tz.getOffset((datetime)t.get(startdatetimeField));
             }
           }
           if(enddatetimeField != null){
              if(t.get(enddatetimeField)!=null){
                c.endd=((datetime)t.get(enddatetimeField)).gettime()+tz.getOffset((datetime)t.get(enddatetimeField));
             }
           }
           if(URL!='id'){
              c.url=(string)t.get(URL);
           }else{
              c.url='/'+c.Id;
           }
           lstcalendar.add(c);
       }
       return lstcalendar;

    }
   
    global class calendarWrapper{
       public string Id;
       public string title;
       public string url;
       public long start;
       public long endd;
    }
}
