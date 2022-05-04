public with sharing class addDeleteController {
    
    @AuraEnabled
    Public static void saveContacts(List<Contact> ListContact) {
        Insert ListContact;
    }

}