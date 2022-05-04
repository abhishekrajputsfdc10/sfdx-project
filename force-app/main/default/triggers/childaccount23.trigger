trigger childaccount23 on Account (after update) 
{
    Set<String> SetParentId = new set<String>();
    String str;
    for (Account a : trigger.new)
    {
        if(a.parentId != null)
        {
            SetParentId.add(a.parentId);
        }
    }

    if(SetParentId.size() > 0 )
    {
        List<Account> lstParentAcc = [ Select name, ChildAccountName__c , (Select Name From ChildAccounts) From Account where id in :SetParentId ]; 
        
        For (Account ac : lstParentAcc)
        {
            List<Account> lstChildAcc = ac.ChildAccounts;
            str='';
            for( Account childAcc : lstChildAcc )
            {
                str = str + ',' + childAcc.name;
            }
            ac.ChildAccountName__c = str;
        }
        if(lstParentAcc.size() > 0 )
        {
            update lstParentAcc;
        }   
    }   
}