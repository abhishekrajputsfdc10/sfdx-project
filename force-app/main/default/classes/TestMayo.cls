public with sharing class TestMayo {
   
    @AuraEnabled(cacheable=true)
    public static List<Account> handleAccout() {
       return [Select id, Name from Account Limit 10];
   }
}