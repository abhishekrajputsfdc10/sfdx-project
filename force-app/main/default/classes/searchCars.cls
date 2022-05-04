public with sharing class searchCars {
    @AuraEnabled(cacheable=true)
    public static List<Car__c> searchCars(string str){
        return [Select id, Name from Car__c where Car_type__c =:str];
    }
   
}