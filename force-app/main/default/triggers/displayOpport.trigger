trigger displayOpport on Case (after Insert, after update) {

if(checkRecursive.runOnce())
{
Set<id> accountids = new Set<id>();
For (Case cs : Trigger.new){
accountids.add(cs.accountid);
}

map<id, List<Opportunity>> mapopty = new map<id, List<Opportunity>>();

List<Opportunity> Listopty = [Select id, StageName, AccountId from Opportunity  where AccountId in : accountids];

for (Opportunity op : Listopty ) {
     if(String.isNotBlank(op.AccountId)){
                   if(!mapopty.containskey(op.accountid)) {
                
                    mapopty.put(op.AccountId, new List<Opportunity>());
                    }
                    mapopty.get(op.AccountId).add(op);
    } 
      }
     
system.debug('list of oppty' +mapopty);
      
List<Case> lstcase = [Select id, Stage_Name__c, accountid from Case where accountid in : accountids];

    For (Case cs : lstcase) {
               system.debug('befo opp'+mapopty.get(cs.accountid));
        For (Opportunity op : mapopty.get(cs.accountid) ){  
               system.debug('opp value is' +op.StageName);      
                cs.Stage_Name__c = op.StageName;

}     
      
}
if (!lstcase.isEmpty()){
Database.update(lstcase);
}
}
}