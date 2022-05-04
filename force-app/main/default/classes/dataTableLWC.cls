public with sharing class dataTableLWC {

    @AuraEnabled(cacheable = true)
    public static List<OTT_Contact__c> fetchAccounts(string str){
        return [SELECT Id,Name, Account__c,Contact__r.Name FROM OTT_Contact__c where account__c =:str and Contact__C != null];
        //return [Select id, Name from contact where ID In (Select Contact__c FROM OTT_Contact__c where account__c = '0010I00002Xn619QAB')];
    }
    
    @AuraEnabled
    public static void deletecon(String str) {
    delete [Select id from OTT_Contact__c where id=:str];
    }


}