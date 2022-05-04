trigger createDealOnOpportunityWon on Opportunity (after insert, after update) {
    
    List <Deal__c> DealToInsert = new List <Deal__c> ();
    // or whatever your custom object name put instead of Sponsorship__c
    
    for (Opportunity o : Trigger.new) {
        
       if (o.StageName == 'Closed Won'){
       
        Deal__c obj = new Deal__c();
        
        obj.Status__c = 'Due Diligence';     
        obj.Opportunity__c  = o.id;
        obj.Name = o.Name; 
        obj.Account__c = o.AccountId;
        
        DealToInsert.add(obj);
        
        
        }
        
    }
    
   
    
        insert DealToInsert; 
   
    
}