Global Class Batchexample02 implements Database.Batchable<sObject>{

Public String myname;

Global Batchexample02(String myname){
this.myname = myname;
}

Global Database.querylocator Start (Database.batchableContext bc)

{
return Database.getquerylocator('Select id, Account_Type__C From Customer__c Where name : myname');
}

Global void execute (Database.BatchableContext bc, List<Customer__c> Scope)

{
For (Customer__c c : scope)
{
c.Account_type__c = 'Saving';

}
update Scope;

}

Global void finish (Database.BatchableContext BC){
}

}