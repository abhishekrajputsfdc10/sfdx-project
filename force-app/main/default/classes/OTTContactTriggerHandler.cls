public without sharing class OTTContactTriggerHandler {

    public static void onInsert(List<OTT_Contact__c> ottconlist) {
        try {

            set<id> setofcontactid = new set<id>();
        set<id> setofaccountid = new set<id>();
        for(OTT_Contact__c ott : ottconlist) {
            setofcontactid.add(ott.Contact__c);
            setofaccountid.add(ott.Account__c);
        }
        
        map<string, Id> mapottcontact = new map<string, Id>();

        for(OTT_Contact__c lstott : [Select id, Account__c, Contact__c from OTT_Contact__c where Contact__c=:setofcontactid and Account__c=:setofaccountid]) {
            string key = lstott.Account__c + '-' + lstott.Contact__c;
            mapottcontact.put(key, lstott.Id);         
        }

        for(OTT_Contact__c ottlst : ottconlist) {
            string key = ottlst.Account__c + '-' + ottlst.Contact__c;
            if(mapottcontact.containsKey(key)) {
               ottlst.addError('Record is already created');
            }
        }

        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }
}