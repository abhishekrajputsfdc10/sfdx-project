public with sharing class ContactBineesh {
    @AuraEnabled
    public static Contact getContact(string acc) {
        try {
            return [Select id from Contact where AccountId =:acc];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}