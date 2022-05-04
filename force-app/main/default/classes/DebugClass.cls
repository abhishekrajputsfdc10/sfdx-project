public with sharing class DebugClass {
    public static void testDebug(List<Account> lstacc) {
       
        List<Account> listacc = [Select id, (Select id from Opportunities) from Account where id In : lstacc];
        for (Account acc : listacc) {
            if(acc.Opportunities.size()>0) {
                Opportunity opp = new Opportunity(
                    name=acc.name,
                    StageName='Prospecting',
                    CloseDate=System.today().addMonths(1),
                    AccountId=acc.Id
                );
            }
        }
    }

    public static void preventDelete(List<Account> oldacclst) {
           
                    
            for(Account acc : [Select id, (select id from contacts) from Account where ID IN : oldacclst]) {
                 if(acc.contacts.size()==1) {
                     acc.addError('You cannot delete the Account');
                 }
            }
        
        
    }
}