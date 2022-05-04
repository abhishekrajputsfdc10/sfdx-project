public with sharing class carTypeSearch {
    @AuraEnabled(cacheable=true)
    public static List<Car_Type__c> getCarType(){
        return [Select id, name from Car_Type__c];
    }    
}