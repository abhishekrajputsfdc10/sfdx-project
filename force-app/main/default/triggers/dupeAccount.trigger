trigger dupeAccount on Account (before insert, before update) {

for (Account a : trigger.new)
{
List<Account> acc = [Select id from Account where Name=:a.name];

if(acc.size()>0){
a.addError('You cannot create');
}



}

}