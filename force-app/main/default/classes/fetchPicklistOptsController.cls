public class fetchPicklistOptsController { 
    
    @AuraEnabled
    Public static List<String> getSelectoption (sObject objObject, string fld){
        system.debug('objObject---->' +objObject);
        system.debug('fld----->' +fld);
        List<string> allopts = new List<string>();
        
        //get the object type of the sObject
        Schema.sObjectType objType = objObject.getSObjectType();

        //Describe the sobject using its sobject type
        schema.DescribesObjectResult objDesribe = objType.getDescribe();
        
        //Get a map of fileds for the sObject
        map <String, Schema.SobjectField> fieldMap = objDesribe.fields.getMap();
        
        //Get the list of Picklist valuse for the field
        List<Schema.PicklistEntry> values = fieldMap.get(fld).getDescribe().getPicklistValues();
        
        //Add these value to the Selectoption list
        for (Schema.PicklistEntry a : values) {
        allopts.add(a.getValue());
        }
        
        system.debug('allopts-->' +allopts);
        allopts.sort();
        return allopts;

   }
   
}