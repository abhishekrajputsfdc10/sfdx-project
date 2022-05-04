public with sharing class getAllObjects {
    @AuraEnabled(cacheable=true)
    public static List<EntityDefinition> getAllCustomSObjects(){
        return [SELECT Id, MasterLabel,  
                    DeveloperName, 
                    QualifiedApiName 
                    FROM EntityDefinition 
                    WHERE IsApexTriggerable = true
                    ORDER BY MasterLabel];
    }

    @AuraEnabled (cacheable=true)
    public static List<SObject> retreieveRecords(String objectName, String fieldAPINames){
        String strQuery = 'SELECT ' + String.escapeSingleQuotes(fieldAPINames) 
                        + ' FROM ' 
                        + String.escapeSingleQuotes(objectName) 
                        + ' LIMIT 20';
            system.debug('Apex query' +database.query(strQuery));
        return database.query(strQuery);
    }
    

     //Retrieve field details based on Object API Name
    /* @AuraEnabled (cacheable=true)
     public static String getFieldName(String selectedObj) {
         system.debug('Pbkect name'+selectedObj);
         Map<string, string> fieldList = new Map<string, string>();
         if(!String.isEmpty(selectedObj)){
             Map<String, String> mapField = new Map<String, String>();
             Map<string,SObjectField> lstFields = 
                 schema.getGlobalDescribe().get(selectedObj).getDescribe().fields.getMap();
 
             for(String str: lstFields.keySet()){
                 mapField.put(str, lstFields.get(str).getDescribe().getLabel());                
             }
             System.debug('I am in Apex' +JSON.serializePretty(mapField));
             return JSON.serializePretty(mapField);
         }
            return null;
     } */
}