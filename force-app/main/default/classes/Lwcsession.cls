public with sharing class Lwcsession {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {       
        return [Select id, name from Account limit 10];
    }
}