trigger LeadConvert on Lead (after update) {

List<Attachment> lstattach=new List<Attachment>();

 // no bulk processing; will only run from the UI
 if (Trigger.new.size() == 1) {

   if (Trigger.old[0].isConverted == false && Trigger.new[0].isConverted == true) {

   // if a new opportunity was created
      if (Trigger.new[0].ConvertedOpportunityId != null) {

   for(Attachment a:[Select Id,ParentId from Attachment where ParentId=:Trigger.new[0].Id]){
      a.ParentId=Trigger.new[0].ConvertedOpportunityId;
      lstattach.add(a);
  }

   update lstattach;
 }

}
 }
 
 }