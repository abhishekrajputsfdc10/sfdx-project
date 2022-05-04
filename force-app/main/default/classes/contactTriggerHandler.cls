/****
@Trigger Contoller Class
@Author Abhishek
*/

public with sharing class contactTriggerHandler {
   
   //Method to update LatestTarget date on Account from Contact
  public static void lastContact(List<Contact> lstcon) {
        map<id,Account> map1 = new map<id,Account>();
        set<id> setid = new set<id>();
        for(Contact con : lstcon) {
            if(con.accountid != null)
            setid.add(con.accountid);
        }
        
        for (Contact con : [Select id, accountid, name, TargetDate__c from Contact where accountid In : setid]) {
            if(!map1.containsKey(con.accountid) && con.TargetDate__c != null) {
                Account ac = new account(id = con.accountid);
                ac.LatestTargetDate__c = con.TargetDate__c;
                map1.put(con.accountid, ac);
            } else {
                if(con.TargetDate__c != null) {
                    if(map1.get(con.accountid).LatestTargetDate__c != null && con.TargetDate__c > map1.get(con.accountid).LatestTargetDate__c) {
                        map1.get(con.accountid).LatestTargetDate__c = con.TargetDate__c;
                    }
                }
            }
        }

        if(!map1.isEmpty()) {
            update map1.values();
        }
       
    }
    
    // Updating Latest Target date at th deletion of Contact in Before Delete
   Public static void deleteTargetdate(List<Contact> lstcon) {
        set<id> setid = new set<id>();
        Set<id> conid = new set<id>();
        for (Contact con : lstcon) {
            setid.add(con.accountid);
            conid.add(con.id);
        }
       List<Account> accountsToUpdate = new List<Account>();
        List<AggregateResult> aggRes  = [SELECT AccountId, Max(TargetDate__c) targetDate FROM Contact WHERE AccountId IN: setid GROUP BY AccountId];
        System.debug('##--aggRes Date: '+ (Date)aggRes[0].get('targetDate'));
        for(AggregateResult agg: aggRes){

            Account acc= new Account(Id= (String)agg.get('AccountId'),  LatestTargetDate__c= (Date)agg.get('targetDate') );
            accountsToUpdate.add(acc);
        }
        update accountsToUpdate; 
        map<id,Account> mapdate = new map<id,Account>();
        List<Contact> lstc = [Select id, TargetDate__c from Contact where accountid In : setid and ID Not In : conid];
        
        for (Contact clst : lstc) {
            if(! mapdate.containsKey(clst.AccountId))
            mapdate.put(clst.AccountId, new Account(LatestTargetDate__c=clst.account.LatestTargetDate__c, Name= clst.Account.Name));
        } 

                      
        map<id,Account> map1 = new map<id,Account>();
        for (Account ac : [Select id,LatestTargetDate__c from Account where ID In :setid]) {
        map1.put(ac.id,ac);
        }
        
        Date dt = null;
        
        
        for (Contact con : lstcon) {
            if(lstc.isEmpty()) {
             map1.get(con.accountid).LatestTargetDate__c = null;
            } else {
                if (con.TargetDate__c == map1.get(con.accountid).LatestTargetDate__c) {
                    for (Contact co : lstc) {
                        dt=co.TargetDate__c;
                        if (dt < co.TargetDate__c) {
                        dt = co.TargetDate__c;
                        }
                        map1.get(con.accountid).LatestTargetDate__c = dt;
                                            
                    }   
                }             
            }
        }
            
        update map1.values();
        
    }

    // Updating Latest Target date at th deletion of Contact in After Delete

    Public static void afterTargetDelete(List<Contact> oldList) {
        Set<Id> accountIdSet = new Set<Id>();
   			
		for(Contact con : oldList){
			accountIdSet.add(con.Accountid);
		 	
		}
		
		
		Map<id,Account> accountMap = new Map<id,Account>();
		for(Contact con : [Select id,accountid,TargetDate__c,account.LatestTargetDate__c 
							from Contact 
							where accountId IN : accountIdSet]){
				
				if(con.TargetDate__c!=null){
				    if(!accountMap.containsKey(con.accountid)){
						Account ac = new Account(id=con.accountId);
						ac.LatestTargetDate__c = con.TargetDate__c;
						accountMap.put(con.AccountId,ac);
					}else{
					
						if(con.TargetDate__c > accountMap.get(con.accountid).LatestTargetDate__c){
								accountMap.get(con.accountid).LatestTargetDate__c = con.TargetDate__c ;
						}
				
					}
				}		
		}
		
		//to set the null value if no contact is present or all contact have null target date
		for(Contact con : oldList){
			if(!accountMap.containsKey(con.accountid)){
					Account ac = new Account(id=con.accountId);
					ac.LatestTargetDate__c = null;
					accountMap.put(con.AccountId,ac);
			}
		}
		
		if(accountMap.size()>0){
			update accountMap.values();
		}
    }
    
    // Method to prevent deletion if name is Abhishek and number of contact is more than one
    Public static void deletePrevent (List<Contact> Conlist) {

        set<id> setids = new set<id>();
        for (Contact con : Conlist) {
            setids.add(con.accountid);
        }
        
        map<id,List<Contact>> mapofcon = new map<id,List<Contact>>();
        List<Contact> lstcon = [Select id, accountid, name from Contact where accountid IN : setids];
        
        List<Contact> templist;
        for (Contact con : lstcon) {
            
            if(!mapofcon.containsKey(con.accountid)) {
            templist=new List<Contact>();
            templist.add(con);
            mapofcon.put(con.accountid,templist);
            } else {
                templist = mapofcon.get(con.Accountid);
                templist.add(con);
                mapofcon.put(con.Accountid, templist);
            }

        }

        For (Contact conn : Conlist) {
            if (mapofcon.get(conn.accountid).size() == 1) {
                conn.addError('You can not delete record');
            } else {
                if (conn.lastname == 'Abhishek') {
                    conn.addError('You can not delete Abhishek Record');
                }
            }
        }
        
    } 

    // Lookup Count Method
    public static void updateCountonAccount(List<Contact> contlist, map<id, Contact> oldcontmap) {
        system.debug('Valling Method');
        Map<Id, List<Contact>> mapAcctIdContactList = new Map<Id, List<Contact>>();
        Map<Id, Integer> mapnew = new Map<Id, Integer>();
        Map<Id, Integer> mapnewfilter = new Map<Id, Integer>();
        Map<Id, List<Contact>> mapAcctIdDelContactList = new Map<Id, List<Contact>>();
        Map<Id, List<Contact>> mapAcctidfilterContact = new Map<Id, List<Contact>>();
        Set<Id> AcctIds = new Set<Id>(); 
        List<Account> listAcct = new List<Account>();

        for(Contact Con : contlist) {
            if(String.isNotBlank(Con.AccountId) && oldcontmap == null) {
                system.debug('mapnew.get(con.AccountId)'+mapnew.get(con.AccountId));
                Integer count = mapnew.get(con.AccountId) == 0 ? 0 : mapnew.get(con.AccountId);
                if(!mapnew.containsKey(Con.AccountId)) {              
                    mapAcctIdContactList.put(Con.AccountId, new List<Contact>());
                    mapnew.put(Con.AccountId, 1);
                    AcctIds.add(Con.AccountId);
                } else {
                    count +=1;
                    mapnew.put(Con.AccountId, count);
                    mapAcctIdContactList.get(Con.AccountId).add(Con); 
                    AcctIds.add(Con.AccountId);
                }
                
            }

            if((con.status__c != 'Draft' && String.isNotBlank(Con.AccountId) && oldcontmap == null) 
                || (oldcontmap != null && oldcontmap.get(Con.Id).status__c == 'Draft' && oldcontmap.get(Con.Id).status__c != Con.Status__c && Con.Status__c != 'Draft' )) {
                    Integer countfilter = mapnewfilter.get(con.AccountId) == 0 ? 0 : mapnewfilter.get(con.AccountId);
                        if(!mapnewfilter.containsKey(con.AccountId)) {
                            mapnewfilter.put(Con.AccountId,1);
                            mapAcctidfilterContact.put(Con.AccountId, new List<Contact>());
                            AcctIds.add(Con.AccountId);
                        } else {
                            countfilter += 1;
                            mapnewfilter.put(Con.AccountId,countfilter);
                            mapAcctidfilterContact.get(Con.AccountId).add(Con);
                            AcctIds.add(Con.AccountId);
                        }              
            }
        }
        
        system.debug('mapnewmapnew'+mapnew);
        system.debug('mapnewfiltermapnewfilter'+mapnewfilter);


        if(AcctIds.size() > 0) {
            listAcct = [SELECT Id, Total_Count__c, Completed_Count__c FROM Account WHERE Id IN : AcctIds];

            for(Account acct : listAcct) {
            Integer noOfConts = 0;
            Integer noOfCompcon = 0;
            if(mapnew.containsKey(acct.Id)) {
                noOfConts += mapnew.get(acct.Id);
            }

            if(mapnewfilter.containsKey(acct.Id)) {
                noOfCompcon += mapnewfilter.get(acct.Id);
            }
            system.debug('noOfContsnoOfConts'+noOfConts);
            system.debug('noOfCompconnoOfCompcon'+noOfCompcon);
            acct.Total_Count__c = acct.Total_Count__c == null ? noOfConts : (acct.Total_Count__c + noOfConts);
            acct.Completed_Count__c = acct.Completed_Count__c == null ? noOfCompcon : (acct.Completed_Count__c + noOfCompcon);
        }
        system.debug('listAcct'+listAcct);
     update listAcct;
    }

    }

    //
    Public static void updatePrimary(List<Contact> conlist, Map<Id,Contact> oldmap) {

        Set<Id> accids = new Set<Id>();
        Set<Id> conids = new set<Id>();
        for (Contact con : conlist) {
            if(con.accountId != null  && con.Opt_Ot__c != oldmap.get(con.Id).Opt_Ot__c && con.Opt_Ot__c) {
                accids.add(con.AccountId);
                conids.add(con.Id);
            }
        }       
       
        String Primaryaddstring = '';
        for (Divisional_Contact__c dc : [Select id, Primary_FA__c, Secondary_FA__c, Contact__c, Account__c from Divisional_Contact__c where Contact__c In: conids]) {           
            Primaryaddstring = dc.Primary_FA__c + ';' + Primaryaddstring;           
        }        
        List<string> setPrimary = Primaryaddstring.split(';');
        Set<String> setofstring = new set<String>(setPrimary);  
                    
        List<Divisional_Contact__c> updatediv = new List<Divisional_Contact__c>();
        for (Divisional_Contact__c divisonallist : [Select id, Primary_FA__c, Secondary_FA__c, Contact__c, Account__c from Divisional_Contact__c where Account__c In: accids and Contact__c Not In: conids]) {
            string primaryfieldaction = '';
            for (String primarydc : setofstring) {
                if(divisonallist.Secondary_FA__c != null) {               
                    string str = divisonallist.Secondary_FA__c;                                    
                    string str1 = str.replace(';' , ',');                   
                    if(str1.contains(primarydc)) {                        
                        primaryfieldaction = primaryfieldaction == '' ? primarydc :  primaryfieldaction + ';' + primarydc;                 
                        setofstring.remove(primarydc);                                            
                    }
                } 
            }  
                if (primaryfieldaction != '' && divisonallist.Primary_FA__c !=null){
                    divisonallist.Primary_FA__c = divisonallist.Primary_FA__c + ';' + primaryfieldaction;
                    updatediv.add(divisonallist);
                } else if (primaryfieldaction != '' && divisonallist.Primary_FA__c ==null) {
                    divisonallist.Primary_FA__c = primaryfieldaction;
                    updatediv.add(divisonallist);
                }          
        }        
       
        if(!updatediv.isEmpty() && setofstring.isEmpty()) {
            update updatediv;
        }        
    }
}