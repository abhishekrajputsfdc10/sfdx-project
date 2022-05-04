global class MySchedulableClass implements Schedulable{ 
    @ReadOnly 
    global void execute (SchedulableContext ctx){ 
    String s = Label.DeleteEntitySubs;
    List<AggregateResult> query = [Select count(id) CD, Subscriberid sd from Entitysubscription GROUP BY Subscriberid HAVING COUNT(Id) >: INTEGER.VALUEOF(Label.DeleteEntitySubs)]; 
    Set<String> subscriberset = new Set<String>(); 
    for(AggregateResult ar : query){ 
    string dt1 = (String)ar.get('sd');
    subscriberset.add(dt1);
    } 
    DeleteEntitySubs rq = new DeleteEntitySubs(subscriberset); 
    Database.executeBatch(rq); 
    } 
    }