trigger childaccount1 on Account (after update) 
{
    map<id,List<Account>> map1 = new map<id,List<Account>>();
    Set<String> SetParentId = new set<String>();
    String str;
    for (Account a : trigger.new)
    {
        if(a.parentId != null)
        {
            SetParentId.add(a.parentId);
            if(map1.containsKey(a.parentId))
            {
                List<Account> lstAcc = map1.get(a.parentId);
                lstAcc.add(a);
            }
            else
            {
                List<Account> lstAcc = new list<Account>();
                lstAcc.add(a);
                map1.put(a.parentId,lstAcc);
            }   
        }
    }

    List<Account> lstanct = [Select name, ChildAccountName__c From Account where id in :SetParentId ];

    For (Account ac : lstanct)
    {
        if(map1.containsKey(ac.id))
        {   
            List<Account> lstCAcc = map1.get(ac.id);
            str='';
            for(Account childAcc : lstCAcc)
            {
                str = str + ',' + childAcc.name;
            }
        }   
        ac.ChildAccountName__c = str;
    }
    update lstanct;
}