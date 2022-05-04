trigger dupeLead on Lead (before insert) {
    List<String> leadEmails = new List<String>();
    for(Lead lead:Trigger.new){
        leadEmails.add(lead.Email);
    }

    List<User> us = [SELECT  Id, Email FROM User WHERE Email IN :leadEmails];

    Set<String> UserEmails = new Set<String>();
    for(User users:us){
        UserEmails.add(users.Email);
    }

    for(Lead lead:Trigger.new){
        if(UserEmails.contains(lead.Email))
        {
          lead.addError('Duplicate Lead'); 
        }
    }
}