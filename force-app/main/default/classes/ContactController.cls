public with sharing class ContactController {
    
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [Select id, name, Title, phone, Email from Contact limit 10];
        
    }
}