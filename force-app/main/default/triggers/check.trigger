trigger check on Contact (before update) {

For (Contact con : Trigger.new) {
If (con.Amount__c > 120) {
con.Amount__c = 100;
}

}

}