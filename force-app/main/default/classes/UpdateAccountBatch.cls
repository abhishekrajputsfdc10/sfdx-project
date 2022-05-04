global class UpdateAccountBatch implements Database.Batchable<sObject>{
 String Query;
Global Database.querylocator start(Database.BatchableContext BC){
 Query = 'Select id, name Description From Account';
 return Database.getquerylocator(Query);
} 

Global void execute(Database.BatchableContext BC, List<Account> scope)
{
List<Account> accList = new List<Account>();
For (Account a : Scope){
a.description = 'updated';
acclist.add(a);
}
update accList;
}

    global void finish(Database.BatchableContext BC){
}


}