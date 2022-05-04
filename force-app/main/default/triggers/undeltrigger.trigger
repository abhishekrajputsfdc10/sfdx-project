trigger undeltrigger on Position__c (after undelete) {



for (Position__c pd : trigger.new) {
system.debug('Parent_Position__c' +pd.Parent_Position__c);
}

}