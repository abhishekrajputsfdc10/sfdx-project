public class AccountTriggerHandler {
    
    
    
    
    
    
    public static void shareAccountRecord(List<Account> newList, Map<id,Account> oldMap){
        
        Map<String,List<String>> countryWithIdMap = new Map<string,List<string>>();
        Set<Id> oldAccountIdSet = new Set<id>();
        for(Account acc: newList){
            
            if(acc.country1__c!=null && (oldMap==null || acc.country1__c!= oldMap.get(acc.id).country1__c)){
                
                if(!countryWithIdMap.containsKey(acc.country1__c)){
                    countryWithIdMap.put(acc.country1__c,new List<String>{acc.Id});
                }
                else{
                    countryWithIdMap.get(acc.country1__c).add(acc.id) ;   
                }
                if(oldMap!=null){
                    oldAccountIdSet.add(acc.id);    
                }
                
            }
            
            
        }
        
        List<AccountShare> shareAccountDeleteList = new List<AccountShare>();
        if(oldAccountIdSet.size()>0){
            
            shareAccountDeleteList = [Select id from AccountShare where rowcause = 'Manual' and AccountId IN: oldAccountIdSet];
        
            if(shareAccountDeleteList.size()>0){
                delete shareAccountDeleteList;
            }
            
        }
        
        List<AccountShare> shareAccountList = new List<AccountShare>();
        if(countryWithIdMap.size()>0){
            
            for(User us:[Select id,country__c 
                         from User
                         WHERE country__c IN:countryWithIdMap.keySet()]){
                
            
                for(String id: countryWithIdMap.get(us.country__c)){
                    
                    AccountShare accountShare = new AccountShare();
                    accountShare.AccountId = id;
                    accountShare.UserOrGroupId = us.id;
                    accountShare.AccountAccessLevel = 'Edit';
                    //accountShare.ContactAccessLevel = 'Edit';
                    accountShare.OpportunityAccessLevel = 'Edit';
                    shareAccountList.add( accountShare);
                    
                }    
                
            }
            
        }
        
        
        if(shareAccountList.size()>0){
            insert shareAccountList;
        }
        
    }

}