Trigger addamount1 on Contact (after update, after insert)
{

set <id> aid = new set<id>();

Decimal sum;

sum = 0;

for (Contact con : trigger.new)

{
aid.add(con.accountid);

sum = sum + con.amount__c;

}

list<Account> lstacnt = [SELECT id, Amount__c FROM Account where id in : aid];

list<Contact> lstcon = [SELECT id, amount__c from Contact where accountid in : aid];

for (Account a : lstacnt)
{



a.amount__c = sum + a.amount__c;

}

update lstacnt;

}