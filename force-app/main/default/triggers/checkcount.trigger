trigger checkcount on Contact (before update)

{

Decimal count;

for (Contact con : trigger.new)

{

if (con.checkbox__c == true && trigger.oldmap.get(con.id).checkbox__c == False)

{

count = 0;

Count = con.Count_Check__c + 1;

con.Count_Check__c = count;

}
}

}