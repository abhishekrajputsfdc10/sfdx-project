public class sendEmail1 {
    public String subject { get; set; }
    public String body { get; set; }
    
     Send_Email__c mhc = Send_Email__c.getInstance();
     string mPhone = mhc.Email__c;

            public PageReference send() {
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

    String addresses;
  
        addresses =  mPhone;
        // Loop through the whole list of contacts and their emails
   

        String[] toAddresses = addresses.split(':', 0);

        // Sets the paramaters of the email
        email.setSubject( subject );
        email.setToAddresses( toAddresses );
        email.setPlainTextBody( body );
    
        // Sends the email
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        
        return null;
    }
}