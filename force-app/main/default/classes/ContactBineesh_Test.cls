@isTest
public with sharing class ContactBineesh_Test {
    @isTest static void ContactBineesh_Test1() {
        
            Account acc = new Account();
            acc.Name='test1';
            insert acc;
            
            Contact con = new Contact();
            con.lastname = 'test2';
            con.AccountId=acc.Id;
            insert con;
            ContactBineesh.getContact(acc.Id);        
          
    }
}