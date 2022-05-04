public class OppTask {
    
    Public static void oppt(List<Opportunity> op){
        
         List<Task> lststk = new List<Task>();
    
    for (Opportunity opp : op) {
        
        if(opp.StageName == 'Closed Won') {
            Task t = new Task();
            t.subject = 'Follow Up Test Task';
            t.Status =  'Open';
            t.Priority = 'Normal';
            t.WhatId = opp.id;
            lststk.add(t);
            
        }
    }
    
    insert lststk;
        
        
    }

}