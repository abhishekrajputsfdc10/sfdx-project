trigger updateChild12 on Opportunity (After update) {

map<id, Opportunity> map1 = new map<id, Opportunity>();

For (Opportunity opp : trigger.new) {
map1.put(opp.id, opp);
}

List<Opportunity> lstop = [Select id, Parent_Opportunity__c , accountid
                          from Opportunity 
                          where Parent_Opportunity__c IN :map1.keyset()];
                          

For (Opportunity op : lstop) {

op.accountid = map1.get(op.Parent_Opportunity__c).accountid;

}
update lstop ;

}