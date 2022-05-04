trigger isPrimary on Contact (after Insert, after update) {

   Set<id> setid = new set<id>();

        For(Contact con : Trigger.new){
        setid.add(con.accountid);        
        }
        
   List<Contact> lstcon = [Select id,isPrimary__c, Primary__c from Contact where accountid IN:setid];
        
   For(Contact c : lstcon )
   {
   If(c.isPrimary__c == True || c.isPrimary__c == false){
   
   c.Primary__c = true;
   }
   
   }
   update(lstcon);

}