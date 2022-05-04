trigger dupecontact on Lead (before insert, before update) {

for (Lead mylead : trigger.new)
{

If (mylead.email!= null)
{

list<contact> con = [Select id from contact where email = :mylead.email];

if (con.size() >0)

{

mylead.dupe_contact__c = con[0].id;


} else
{

mylead.dupe_contact__c = null;

}
}
}
}