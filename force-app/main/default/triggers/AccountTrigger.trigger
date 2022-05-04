trigger AccountTrigger on Account( after insert, after update)
{
    
    
    if(trigger.isAfter){
        
        if(Trigger.isInsert){
            AccountTriggerHandler.shareAccountRecord(Trigger.new,null);
        }
        if(Trigger.isUpdate){
            AccountTriggerHandler.shareAccountRecord(Trigger.new,Trigger.oldMap);
        }
        
    }
    
    Set<ID> setParentAccId = new Set<ID>();
    for(Account acc : Trigger.New)
    {
        if(acc.ParentId != null)
        {
            setParentAccId.add(acc.ParentId);
        }
    }
    
    if(setParentAccId.size() > 0 )
    {
        Map<ID,Account> mapParentAccount = new Map<ID,Account>([select id,ChildAccountName__C from account where id in :setParentAccId ]);
        List<Account> lstParentAcc = new List<Account>();
        for(Account acc : Trigger.New)
        {
            if(acc.ParentId != null && mapParentAccount.containsKey(acc.ParentId) )
            {
                Account parentAcc = mapParentAccount.get(acc.ParentId);
                parentAcc.ChildAccountName__C = acc.Name;
                lstParentAcc.add(parentAcc);
            }
        }
        if(lstParentAcc.size() > 0 )
        {
            update lstParentAcc;
        }
    }
}