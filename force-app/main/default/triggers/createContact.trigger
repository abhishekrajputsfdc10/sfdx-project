trigger createContact on Account (After update) {
List<Contact> lstcon = new List<Contact>();

For (Account ac : Trigger.new){

If(!(ac.Phone == Trigger.oldmap.get(ac.id).Phone))

{
Contact con = new Contact();

con.lastname = ac.name;
con.phone = ac.phone;
lstcon.add(con);
}


}
insert lstcon;

}