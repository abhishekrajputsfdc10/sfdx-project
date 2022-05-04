public class aaPage26E {
    Job_Application__c t;
    ApexPages.StandardController controller;
    public aaPage26E(ApexPages.StandardController controller) {
        this.controller = controller;
        t = (Job_Application__c) Controller.getRecord();
    }
    public list<SelectOption> getRecordTypes() {
        list<SelectOption> options = new list<SelectOption>();
        for (list<RecordType> rts : [SELECT ID, name FROM RecordType WHERE SObjectType = 'Job_Application__c' ORDER BY name]) {
            for (RecordType rt : rts) {
                options.add(new SelectOption(rt.ID, rt.Name));
            } 
        }
        return options;
    }
}