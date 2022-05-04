trigger create on Contact (before Insert) {

List<Account> lstanct = new List<Account>();
map<String,Contact> map1 = new map<String,Contact>();
For (Contact con : Trigger.new){
String accname = con.lastname;
Account a = new Account(name=accname);
lstanct.add(a);
map1.put(accname,con);

}
insert lstanct;

For (Account ac : lstanct)
{

map1.get(ac.name).accountid = ac.id;

}
}