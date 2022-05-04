@isTest
Public class Hsvc_ChildAccountHelper_test {
           Static testmethod void m1 () {
             Account acct = new Account ();
              acct.name = 'test';
             insert acct;
            }
       
    Public static testmethod void m2() 
    {   
        Account accts = new Account();
        accts.parentid = 'acct.id';
    }


}