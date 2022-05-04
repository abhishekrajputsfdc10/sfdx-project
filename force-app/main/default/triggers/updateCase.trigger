trigger updateCase on Account (After Update) {
Map<id,List<Contact>> map1 = new map<id,List<Contact>>();
For (Account a : Trigger.new) {
map1.put(a.id,a.contacts);
}
List<Contact> lstcon = [Select id, name,accountid, (Select id, accountid,contactid From Cases) From Contact where accountid in:map1.keyset()];

For (Contact Con : lstcon) {

For (Case ca : con.cases){

ca.accountid = con.accountid;
}
update con.cases;

}


}