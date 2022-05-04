trigger checkdel on Asset (before delete) {
List<Asset> lst1 = [Select id, ParentId,Restore_Id__c from Asset where ID in : trigger.new];
List<Asset> lstacc = new List<Asset>();
for (Asset asst : lst1 ) {

asst.ParentId=asst.Restore_Id__c;
lstacc.add(asst);

}
update lstacc;

}