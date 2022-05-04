trigger Accnt on Account (After update) {
Set<id> setids = new Set<id>();
For (Account a : Trigger.new)
{
setids.add(a.id);
}

List<Contact> lst = [Select id, name, Amount__C From Contact where accountid in:setids];

For (Contact con : lst) {

con.amount__C = 100;
}

update lst;

}