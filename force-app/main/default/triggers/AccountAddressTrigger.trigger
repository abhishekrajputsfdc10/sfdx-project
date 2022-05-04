trigger AccountAddressTrigger on Account (before insert, before update) {
    
    
    for (Account a : trigger.new){
        If(a.BillingPostalCode!=null && a.Match_Billing_Address__c == True) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }
        
    }

}