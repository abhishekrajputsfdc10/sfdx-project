// Automatically create an Opp when an Account is created
trigger AutoOpp on Account(after insert) {
  List<Opportunity> newOpps = new List<Opportunity>();
  for (Account acc : Trigger.new) {
    Opportunity opp = new Opportunity();
    opp.Name        = acc.Name + ' Opportunity';
    opp.StageName   = 'Prospecting';
    opp.CloseDate   = Date.today() + 90;
    opp.AccountId   = acc.Id; // Use the trigger record's ID
    newOpps.add(opp);
  }
  insert newOpps;
}