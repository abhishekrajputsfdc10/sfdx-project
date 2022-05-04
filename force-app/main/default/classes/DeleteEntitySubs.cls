public class DeleteEntitySubs implements Database.Batchable<sObject> {


    Set<String> query = new Set<String>();

   public DeleteEntitySubs(set<String> query) {
       this.query = query;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('const' + query);
        Set<string> setstrng = new Set<string>();
        setstrng.addAll(query);

        String query1 = 'Select Subscriberid from Entitysubscription where Subscriberid=:setstrng';
        return Database.getQueryLocator(query1);
    }
    
    
     public void execute(Database.BatchableContext BC, List<Entitysubscription> entitysubs) {
        delete entitysubs;
         
     }
    
    
    public void finish(Database.BatchableContext bc){
    
    }

}