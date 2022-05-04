@isTest
Public Class updatecontact  {

Public Static testmethod void test() {
List<Account> lstanct = new List<Account>();
For (Integer i=0;i<20;i++) {
Account a = new Account(Name='Name'+i,Country__c='India');
lstanct.add(a);
} 
Test.startTest();
insert lstanct;
Test.StopTest();
}

Public Static testmethod void test1() {

list<Account> lstan = [Select name , Country__c FROM Account];
for(Account ac : lstan)
{
ac.country__C='US';
}
Test.startTest();
update lstan;
Test.StopTest();

List<Contact> lstcnct = [Select Country__c, name, id FROM Contact where accountid in: lstan];
For (Contact con : lstcnct){
System.assertequals('India', con.Country__c);
}


}
}