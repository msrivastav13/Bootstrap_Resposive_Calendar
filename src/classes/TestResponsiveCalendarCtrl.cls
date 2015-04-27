@isTest
private class TestResponsiveCalendarCtrl{
   
   static testmethod void testgetCalendarItems(){
       Test.startTest();
       Account acc=new Account();
       acc.Name='Test';
       insert acc;
       Event e=new Event();
       e.Subject='Test';
       e.StartDatetime=system.today();
       e.EndDatetime=system.today()+10;
       insert e;
       list<ResponsiveCalendarCtrl.calendarWrapper> lstwrapper=ResponsiveCalendarCtrl.getCalendarItems('Event','id','StartDatetime','EndDateTime','Subject');
       system.assert(lstwrapper.size()==1);
   }

}