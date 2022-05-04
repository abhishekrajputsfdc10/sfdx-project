trigger PrimaryContact on Contact (before update, before insert) {

Set<id> setid = new set<id>();
map<id, Account> map1 = new map<id, Account>();

For (Contact con : Trigger.new){

setid.add(con.accountid);
}

map1 = new map<id,Account>([Select id, Primary_Contacta__c, (Select id, accountid, Primary__c from Contacts) From Account where ID IN:setid]);

For (Contact c : [Select id, accountid, lastname from Contact where Primary__c = True]){
    Account ac = map1.get(c.accountid);
    ac.Primary_Contacta__c = c.lastName;

}

update map1.values();



}