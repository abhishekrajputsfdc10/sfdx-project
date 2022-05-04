trigger ClosedOpportunityTrigger on Opportunity (After insert, After update) {
    
    OppTask.oppt(Trigger.new);
    
   /* List<Task> lststk = new List<Task>();
    
    for (Opportunity opp : trigger.new) {
        
        if(opp.StageName == 'Closed Won') {
            Task t = new Task();
            t.subject = 'Follow Up Test Task';
            t.Status =  'Open';
            t.Priority = 'Normal';
            t.WhatId = opp.id;
            lststk.add(t);
            
        }
    }
    
    insert lststk;*/

}