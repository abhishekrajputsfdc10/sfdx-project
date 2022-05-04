trigger word on Account (before update, before insert) {

List<Account> actlst = [SELECT name, country__c, id From Account];

for (Account ac : trigger.new){

ac.country__c = 'hello';

}

update actlst;

}