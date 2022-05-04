public class tableWithManageCtrl  {
    
    @AuraEnabled
    Public Static List<Account> fetchAccount(){
        
        List<Account> newlist = new List<Account>();
        
        For(Account ac : [select id, Name, Type, Industry, Phone, Fax from account LIMIT 10]) {
            newlist.add(ac);
        }
        return newlist;
    }

}