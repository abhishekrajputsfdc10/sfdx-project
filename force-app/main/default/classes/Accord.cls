public class Accord {
    
    @AuraEnabled
    Public static List<Contact> getContacts(){
        List<Contact> lstcon = [Select id, Name, Email from Contact limit 10];
        return lstcon;
    }

}