public class CaseMasterTriggerhandler {
       
    public static void openCaseCount(List<Account> acclst) {


        List<Case> caselst = [Select id from case where status='New' and accountid In : acclst];

        for (Account acc : acclst) {
             acc.Open_Cases__c = caselst.size();
        }

    }

}