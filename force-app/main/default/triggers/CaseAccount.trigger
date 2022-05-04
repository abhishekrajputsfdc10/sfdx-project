trigger CaseAccount on Contact (after update) {

map<id,id> map1 = new map<id,id>();

for (Contact con : Trigger.new)

{

map1.put(con.id,con.accountid);

}


List<CASE> ca = [SELECT accountid, contactid from CASE where contactid in : map1.keyset()];

for (CASE cas : ca)

{

cas.accountid = map1.get(cas.contactid);

}

update ca;

 
}