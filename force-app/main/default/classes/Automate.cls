Public class Automate {
Public void AutomateJobs() 
  {
      for(CronTrigger delCron: [SELECT Id FROM CronTrigger LIMIT 150 ])  {
      System.abortJob(delCron.Id);
      } 
  }
}