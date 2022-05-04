trigger contact_Util_Trg on Contact (after insert , after update) {
// Why after ? you can get the Contact id in after insert triger , in before insert you can get conact id
Set<Id>accIds=new Set<Id>();
List<Account>lstUpdate=new list<Account>();
map<Id,Account>mapOfaccounttttIdAcc=new Map<Id,Account>();
Map<Id,List<Contact>>mapofIdandLst=new Map<Id,List<Contact>>();
for(Contact con:trigger.new){
    accids.add(con.AccountId);
}


List<Contact>tempLst;

//creating the map of accountid and list of contact .

for(contact con: [select id ,accountid from contact where accountid in : accIds]){
    if(mapofIdandLst.get(con.AccountId)==null){
        tempLst=new List<Contact>();
        tempLst.add(con);
        mapofIdandLst.put(con.AccountId,tempLst);
    } else{
        tempLst=mapofIdandLst.get(con.AccountId);
        tempLst.add(con);
         mapofIdandLst.put(con.AccountId,tempLst);
    }     
    
}
for(Account acc:[select id,NumberofLocations__c from account where id in :accids]){
    acc.NumberofLocations__c =mapofIdandLst.get(acc.id).size();
    lstUpdate.add(acc);
}
if(lstUpdate.size()>0){
    update lstUpdate;
}




}