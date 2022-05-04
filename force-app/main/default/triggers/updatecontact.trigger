trigger updatecontact on Account (after insert, after update) {

map<id,Account> map1 = new map<id,Account>();

//List<Account> ca = [Select id,name,Country__C from Account];

for (Account a : trigger.new)

{

map1.put(a.id,a);

}

List<Contact>  lstcon = [SELECT id, name, Country__c, Accountid FROM contact where accountid in :map1.keyset()];

for(contact c : lstcon) {

c.Country__c = map1.get(c.accountid).Country__c;

}

update lstcon;

}