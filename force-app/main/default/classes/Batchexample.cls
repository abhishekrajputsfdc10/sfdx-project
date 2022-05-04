Global Class Batchexample implements Database.Batchable<sObject>{

Global Database.querylocator start (Database.BatchableContext bc)

{

String query = 'SELECT id, name From Account';
return database.getquerylocator(query);
}

Global void execute (Database.BatchableContext bc, List<Account> scope)

{


For (Account a : scope){

a.name = a.name.remove('updated');

}
update scope;
}

Global void finish (Database.BatchableContext bc){

}

}