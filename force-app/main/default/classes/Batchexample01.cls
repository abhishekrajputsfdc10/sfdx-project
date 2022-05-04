Global Class Batchexample01 implements Database.Batchable<Sobject> {

Global Database.querylocator start (Database.BatchableContext Bc){

String q = 'Select id, phone,Account.phone From Contact';
return Database.getquerylocator(q);
}

Global void execute (Database.BatchableContext bc, List<Contact> con)

{

For (Contact c : con)
{

c.phone = c.Account.phone;


}
update con;

}

Global void finish (Database.BatchableContext BC)
{

}


}