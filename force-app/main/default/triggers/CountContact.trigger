trigger CountContact on Contact (after insert, after update) {

set<id> setid = new set<id>();

For (Contact con : Trigger.new)

{
setid.add(con.accountid);

}

List<Contact> listcon = [SELECT id,name from Contact where accountid in :setid];

List<Account> listacnt = [SELECT id,name from Account where id in : setid];

for (Account acnt : listacnt)

{

acnt.No_of_Contact__c = listcon.size();

}

update listacnt;


}