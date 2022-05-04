@isTest
private class DeleteEntitySubsTest {
static testMethod void unitTest() {
    /*List<EntitySubscription> listEntitySub = new List<EntitySubscription>();
    Account acc = new Account();
    acc.Name='Test1';
    insert acc;
    //listEntitySub = [SELECT Id FROM EntitySubscription WHERE ParentId =: acc.Id AND SubscriberId ='00528000000zlnw'];
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    
    User u = new User(
        Alias = 'testu',
        Email = 'test@example.com',
        EmailEncodingKey = 'UTF-8',
        LastName = 'Test',
        LanguageLocaleKey = 'en_US',
        LocaleSidKey = 'en_US',
        TimeZoneSidKey='America/Los_Angeles',
        ProfileId = p.Id,
        UserName='test234abhisrinu@example.com'
        );

    Insert u;

    EntitySubscription entitySub = new EntitySubscription(ParentId = acc.Id, SubscriberId = u.Id);
    insert entitySub; */
    

    set<string> setofstring = new set<string>{'Test1'};

    Test.startTest();
    DeleteEntitySubs obj = new DeleteEntitySubs(setofstring);
        DataBase.executeBatch(obj);            
    Test.stopTest();    

}

}