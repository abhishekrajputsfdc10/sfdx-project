public with sharing class ArticleFeedbackController{

    public ArticleFeedbackController(ApexPages.StandardController controller) {

    }


  public ArticleFeedbackController(){}
  
  public string subject{get; set;}
  public string body{get; set;}
  
  
  public PageReference send() {
      try
      {
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

        String addresses;
        List<String> sendTo = new List<String>();
        for(Send_Email1__c send:Send_Email1__c.getAll().values()){
            sendTo.add(send.email__c);
        }
       
        // Sets the paramaters of the email
        email.setSubject( subject );
        email.setToAddresses(sendTo);
        email.setPlainTextBody( body );
    
        // Sends the email
        Messaging.SendEmailResult [] r = 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Info,'Feedback sent successfully');
        apexpages.addmessage(msg);
        }
        catch(Exception e){
            e.getMessage();
        }
        return null;
    }   
  
}