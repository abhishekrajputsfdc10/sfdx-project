trigger updateLatesttrigger on Contact (after insert, after update, after delete, before delete) {
   if (trigger.isAfter) {
      if(trigger.isInsert || trigger.isUpdate) {
       //  contactTriggerHandler.lastContact(Trigger.new);
      }
      if(Trigger.isInsert && Trigger.isAfter) {
         //contactTriggerHandler.updateCountonAccount(Trigger.New, null);
      }

      if(Trigger.isUpdate && Trigger.isAfter) {
         contactTriggerHandler.updatePrimary(Trigger.New, Trigger.oldMap);
         //contactTriggerHandler.updateCountonAccount(Trigger.New, Trigger.oldMap);
      }
      if(trigger.isDelete) {
         system.debug('Trigger executing');
         //contactTriggerHandler.deletePrevent(Trigger.old);
         //contactTriggerHandler.deleteTargetdate(Trigger.old);

      }
   }

   if(trigger.isBefore) {
      
   }
}