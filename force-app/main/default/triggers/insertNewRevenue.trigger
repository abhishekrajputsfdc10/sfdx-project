trigger insertNewRevenue on Opportunity (after update) {
List<Opportunity> listOppor = new List<Opportunity>();
List<Contract> listContr = new List<Contract>();
for(Opportunity opp : Trigger.new)
{

   if(opp.StageName == 'closed Won')
       {
          Opportunity oppNew = opp.clone(False);
          oppNew.Type = 'Upsell';
          oppNew.StageName = 'Forecasted';
           listOppor.add(oppNew);
       }
    if(listOppor.size() > 0)
     insert listOppor;    
   
}
}