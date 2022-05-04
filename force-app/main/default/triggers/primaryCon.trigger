trigger primaryCon on Contact (After Update) {

Set<id> setids = new Set<id>();
For (Contact con : Trigger.new){
setids.add(con.accountid);
}

List<Account> lstscnt = [Select id, name, prime__C, (Select id, name, Primary__C, phone From Contacts) From Account Where id in:setids];

For (Account a : lstscnt)
 
 {    
    for (Contact conn : a.contacts)
    {
    if (conn.Primary__C == True){
    
    a.prime__c = conn.phone;    
    
    
    }    
    } 
 }
 update lstscnt;
}