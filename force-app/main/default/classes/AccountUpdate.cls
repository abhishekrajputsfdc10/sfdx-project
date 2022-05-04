global class AccountUpdate Implements Database.Batchable <sObject> {
    global Database.queryLocator start(Database.BatchableContext bc) {
        String SOQL = 'SELECT Id, Description FROM Account';
        return Database.getQueryLocator(SOQL);
    }

    global void execute(Database.BatchableContext bc, List<Account> listAccount) {
        for(Account a : listAccount) {
            a.Description = 'Updated on ' + system.today();
        }
        update listAccount;
    }

    global void finish(Database.BatchableContext bc) {
    }
}