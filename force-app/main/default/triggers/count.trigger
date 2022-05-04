Trigger count on Contact (after update)
{

set <id> aid = new set<id>();

for (Contact con : trigger.new)

{
aid.add(con.accountid);

}

list<Account> lstacnt = [SELECT id, No_of_count__c FROM Account where id in : aid];

List<Contact> lstcon = [SELECT id from Contact where accountid in : aid];

for (Account a : lstacnt)
{

a.No_of_count__c = lstcon.size();

}

update lstacnt;

}