trigger uncheck on Contact (after update) {
Id selectedAddressId;
List<Contact> lst = new List<Contact>();
Set<id> setids = new Set<id>();

For (Contact c : Trigger.new){
if(c.Primary__C == True){
setids.add(c.id);
}
}
List<Contact> lstcon = [Select id, name ,Primary__C From Contact Where id NOT in : setids];

For (Contact con : lstcon){
if (con.Primary__C == True){
con.Primary__C = False;
lst.add(con);
}
}
update lst;
}