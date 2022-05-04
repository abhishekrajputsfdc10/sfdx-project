Trigger EventBefore1 on Event (before insert, before update){

map<id,id> map1 = new map<id,id>(); 
List<id> lstid = new list<id>();
Set<id> setids = new Set<id>();
For (Event e : trigger.new)
{
lstid.add(e.id);
}
List<eventrelation> lstds = [SELECT relationid FROM EventRelation where EventID in:lstid];
 for (eventrelation evn : lstds){
 setids.add(evn.relationid); 
 } 
 List<Contact> conlist = [Select id, accountid From Contact where id in: setids]; 
 For (Contact con : conlist){
 map1.put(con.id,con.accountid);
 } 
    For (Event e1 : trigger.new){              
              
               e1.whatid = map1.get(e1.id);         
            
                                 
            
   }
            
}