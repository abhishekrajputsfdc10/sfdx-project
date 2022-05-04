public with sharing class utilityClassforLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(string str) {
        string tempInput = '%' + str + '%';
        if(str=='') {
            return null;
        }
        return [Select Name from Account where name LIKE : tempInput];

    }
}