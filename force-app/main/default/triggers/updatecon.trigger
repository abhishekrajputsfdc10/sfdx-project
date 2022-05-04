trigger updatecon on Account (After update) {

map<id,String> map1 = new map<id,String>();
For (Account a : Trigger.new){
map1.put(a.id,a.name);
}
List<Contact> lstcon = [Select id, name, accountid, LastName From Contact where accountid in: map1.keyset()];

For (Contact con : lstcon){

String str ;

Str = map1.get(con.accountid);
 System.debug('The value is: ' + str);
con.lastname = con.lastname + str;

}

update lstcon;
}