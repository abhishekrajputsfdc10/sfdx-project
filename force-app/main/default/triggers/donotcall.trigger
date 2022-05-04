trigger donotcall on Contact (after update) {
List<Contact> lstcon = [Select id, department from Contact where Department='HR' and id in : Trigger.new];
system.debug('lstcon'+lstcon);
List<Contact> lc = new List<Contact>();
for (Contact con : lstcon) {
con.Donotcall__c = True;
lc.add(con);
}
update lc;

}