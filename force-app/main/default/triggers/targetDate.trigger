trigger targetDate on Contact (after insert) {

List<id> lst = new List<id>();

for (Contact con : trigger.new) {
lst.add(con.accountid);
}

/*
Map<id,Account> accountMap = new Map<id,Account>();

    for(Contact con :[Select id,accountid, targetDate__c 
                        from Contact
                         where accountid IN : lst and accountid!=null]){
                         
          if(!accountMap.containskey(con.accountid)){
            Account tempacc = new Account(id=con.accountId);
            tempacc.latestTargetDate__c = con.targetDate__c;
            accountMap.put(con.accountId, tempacc);      
          }else{
          
              if(con.targetDate__c!=null){
                  if(accountMap.get(con.accountid).latestTargetDate__c!=null 
                      && con.targetDate__c > accountMap.get(con.accountid).latestTargetDate__c){
                      
                      accountMap.get(con.accountid).latestTargetDate__c = con.targetDate__c;
        
                  }    
            
              }
          
          }
          
          
          
          
          
           
     }
     
     if( accountMap.size()>0){
     
     update accountMap.values();
     }                     
        
        
   */
   List<Account> accounttoUpdate = new List<Account>();
   
   for(Account ac: [Select id,LatestTargetDate__c ,(select targetDate__c from Contacts) from account where id IN : Lst]){
        
        Date tempDate =null;
        for(Contact con: ac.Contacts){
        
            if(tempDate == null){
               tempDate = con.targetDate__c;
            }
            else{
                if(con.targetDate__C > tempDate){
                    tempDate= con.TargetDate__c;
                }
            }
        }
        
        if(tempDate!=null){
            ac.LatestTargetDate__c = tempDate;
            accounttoUpdate.add(ac);
        }
   
   } 
   
   if(accounttoUpdate.size()>0){
           update accounttoUpdate;
   }
   
   
   }