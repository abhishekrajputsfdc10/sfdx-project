Trigger chnageowner on Contact (after update) {

map<id,id> map1 = new map<id,id>();
For(Contact con : trigger.new){
map1.put(con.id,con.ownerid);
}

List<Case> cs = [Select id, ownerid, contactid From case where contactid in: map1.keyset()];

For (Case ca : cs)
{
ca.ownerid = map1.get(ca.contactid);

}
update cs;

}