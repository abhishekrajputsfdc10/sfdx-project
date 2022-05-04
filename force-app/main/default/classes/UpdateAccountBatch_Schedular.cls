global class UpdateAccountBatch_Schedular implements Schedulable{
   global void execute(SchedulableContext sc) {
      UpdateAccountBatch  uab = new UpdateAccountBatch (); 
      database.executebatch(uab);
   }
}