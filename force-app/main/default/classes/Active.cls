public with sharing class Active {

public Active(ApexPages.StandardController controller) {
    }

     public List<Account> po { get; set; }
     
  
    public Active(){
        po = [SELECT id, show__c, name, phone From Account];
    }
    
}