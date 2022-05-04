trigger addJob on Candidate__c (after insert) {

list<Job_Application__c> lst = new list<Job_Application__c>();

for (Candidate__c cd : Trigger.new)

{

Job_Application__c jb = new Job_Application__c(Status__c='new');

jb.Cover_Letter__c = 'hi I am neww';


insert jb;

}





}