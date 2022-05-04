trigger ContactUpdate on Account (after update) {

map<id,Account> mapaccount = new map<id,Account>();

List<Contact> conlst = new List<Contact>();

For (Account acc : trigger.new) {

mapaccount.put(acc.id,acc);

}

conlst = [SELECT MailingStreet, MailingCity, AccountId FROM Contact WHERE AccountId IN : mapaccount.keyset()];

if(conlst.size() > 0) {
for (Contact con : conlst) {

            con.MailingStreet = mapAccount.get(con.AccountId).BillingStreet;
            con.MailingCity = mapAccount.get(con.AccountId).BillingCity;

}

update conlst;
}

}