trigger cotactname on contact (after insert, after update){
list<contact> lst1 = new list<Contact>();
map<id, contact> mp1 = new map<id, contact>();
string st ='';

    for(Contact c : trigger.new){
        if(c.accountid != NULL){
           mp1.put(c.accountid, c);
           lst1.add(c);        
        }  
    }
map<id,list<contact>> mp2 = new map<id,list<Contact>>();

List<Account> lst = [Select id, name, child_name__c, (Select name from Contacts) From Account where id IN:mp1.keyset()];

For (Account a : lst){
mp2.put(a.id,a.contacts);
    for(contact c : a.contacts){
       st = st + ' , ' + c.name;
    }
    a.child_name__c = st;
  }
update lst;
}