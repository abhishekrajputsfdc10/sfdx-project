public with sharing class ContactCustomLookup {
    @AuraEnabled(Cacheable=true)
    public static List<Contact> getContcats(string searchTerm) {
        //List<Contact> lstcon = new List<Contact>();
        if(!String.isEmpty(searchTerm)) {
            return [Select id, name from Contact where accountid =: searchTerm];
        } else {
            return null;
        }
    }
}