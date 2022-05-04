trigger PrimContact on Contact (after insert, after update) {

Set<id> setid = new set<id>();

For(Contact con : Trigger.new){
setid.add(con.accountid);
system.debug('I am here');
}


Map<id, Boolean> map1 = new map<id, Boolean>();
map<id, Account> map2 = new map<id, Account>();
List<Account> lstac = [Select id, Primary_Contacta__c, (Select id,name, Primary__c from Contacts where Primary__c = True) from Account where ID IN: setid];


For (Account ac : lstac){
  
  map1.put(ac.id, false);
  
  If(ac.Contacts.size()>0){
  map1.put(ac.id, true);
  map2.put(ac.id,new Account(id=ac.id,Primary_Contacta__c = ac.contacts[0].name));
  }
  }

  For(Contact c : Trigger.new){
  if(map1.containskey(c.accountid) && map1.get(c.accountid) && c.primary__c == True){
  c.adderror('Already Primary');
  }else if(c.Primary__c == true && !map1.containskey(c.accountid)){
  map2.put(c.accountid, new Account(id = c.accountid, Primary_Contacta__c = c.name));
  }
    }
    
    If(map2.size()>0){
    update map2.values();
    }



}