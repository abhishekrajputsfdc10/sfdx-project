trigger cotactcountt on contact (after insert, after update){
list<contact> lst1 = new list<Contact>();
map<id, contact> mp1 = new map<id, contact>();
Integer st =0;

    for(Contact c : trigger.new){
        if(c.accountid != NULL){
           mp1.put(c.accountid, c);
           lst1.add(c);        
        }  
    }
map<id,list<contact>> mp2 = new map<id,list<Contact>>();

List<Account> lst = [Select id, name, Number_of_Contacts__c, (Select name from Contacts) From Account where id IN:mp1.keyset()];

For (Account a : lst){

    for(contact c : a.contacts){
       st = st + a.contacts.size();
    }
    a.Number_of_Contacts__c = st;
  }
update lst;
}