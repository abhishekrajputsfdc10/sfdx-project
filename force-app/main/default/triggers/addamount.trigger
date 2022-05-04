Trigger addamount on Contact (after update)
{

set <id> aid = new set<id>();

Decimal sum;

sum = 0;

for (Contact con : trigger.new)

{
aid.add(con.accountid);

}

list<Account> lstacnt = [SELECT id, Amount__c FROM Account where id in : aid];

list<Contact> lstcon = [SELECT id, amount__c from Contact where accountid in : aid];

for (Account a : lstacnt)
{

for (Contact con1 : lstcon)


{
sum = sum + con1.amount__c;


}

a.amount__c = sum;

}

update lstacnt;

}