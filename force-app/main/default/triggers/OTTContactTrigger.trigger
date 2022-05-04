trigger OTTContactTrigger on OTT_Contact__c (before insert, before update) {
    OTTContactTriggerHandler.onInsert(Trigger.new);
}