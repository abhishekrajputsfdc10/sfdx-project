trigger chnagecountry on Account (after insert, after update) {


for (Account ac : trigger.new)


{

if (ac.Country__c!= Null)

{

Contact con = new Contact();

con.LastName = 'Raja';

con.Country__c = ac.Country__c;



insert con;


}


}

}