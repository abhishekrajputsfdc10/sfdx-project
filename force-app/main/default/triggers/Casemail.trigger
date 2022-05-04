trigger Casemail on Case (before insert, before update) {

list<id> id = new list<id>();

for (Case ca : trigger.new)

{

id.add(ca.contactid);
}

map <id,contact> map1 = new map<id,contact>();


for (contact con : [SELECT id, email, Alternative_Email__c from contact where id in : id])

{

map1.put(con.id,con);

}

for (Case caa : trigger.new)

{

if(map1.get(caa.contactid).email != Null)


{

caa.email__c = map1.get(caa.contactid).email;

}

else

{

caa.email__c = map1.get(caa.contactid).Alternative_Email__c;

//update caa;

}

}

}