Trigger EventBefore on Event (before insert, before update){

List<EventRelation> lstevent = [Select relationid,id from Eventrelation where eventid in: trigger.new];

            
}