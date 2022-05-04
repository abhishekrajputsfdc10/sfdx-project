public with sharing class contrller {
Public id Current_Acc_Id;

    public contrller(ApexPages.StandardController controller) {
    Current_Acc_Id = controller.getRecord().id;
    }

    public List<Contact> getrelatedContacts(){
        List <contact> conList = New List<Contact>();
        for(Account acc:[select id,name,(select name,id,email from contacts) from account where id=:Current_Acc_Id]){
           for(contact con:acc.contacts)
               conList.add(con); 
        }
        return conList;
    }
}