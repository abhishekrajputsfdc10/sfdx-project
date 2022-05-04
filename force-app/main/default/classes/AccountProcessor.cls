public class AccountProcessor {
    
    
    @future
    public static void countContacts(List<id> accountIds){
    
        List<Account> accountList = new List<Account>();    
            
        AggregateResult[] groupedResults = [select count(Name),accountid from contact where accountid <> null group by accountid];
        
                
        for(AggregateResult ar: groupedResults){
            
            Account ac = new Account(id = String.valueof(ar.get('accountid')));
            ac.Number_of_Contacts__c = Integer.valueOf(ar.get('expr0'));
            
            accountList.add(ac);
        }
        
        
        if(accountList.size()>0){
            update accountList;
        }
        
    }

}