trigger childaccount on Account (after update) {

map<id,Account> map1 = new map<id,Account>();
Set<id> setids = new Set<id>();

String str='';

for (Account a : trigger.new)
{
if(a.parentId != null)
map1.put(a.parentId,a);

}
List<Account> lst = [Select name, parentid, id From Account Where parentid in: map1.keyset()];
List<Account> lstanct = [Select name, ChildAccountName__c From Account where id in: map1.keyset()];

For (Account ac : lstanct){
       For(Account acc : lst){

str = str + ',' + acc.name;

}
ac.ChildAccountName__c = str;
}
update lstanct;
}