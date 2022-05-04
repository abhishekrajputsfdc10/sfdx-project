@isTest
Public Class dupe {

Public static testmethod void du(){
string adderror;
Account a1 = new Account(name='Test');
insert a1;

System.assertequals('You cannot create',adderror);

}


}