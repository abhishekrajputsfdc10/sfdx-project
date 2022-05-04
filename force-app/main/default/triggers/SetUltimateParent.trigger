trigger SetUltimateParent on Account (before insert, before update) 
/*
Version        : 2.0
Company        : Websolo Inc. 
Description    : The trigger calculates Ultimate Parent ID ONLY for the updated/inserted Account with Hierarchy of parent Accounts to 5 levels up.

Scheduled APEX job will recalculate Ultimate Parent ID for all Account overnight to make sure they calculated properly in case if for example Account moved to another Account
*/ 
{
    list<Account> ListAcc = new list<Account>();
    set<id> idAcc = new set<id>();
    for(Account a: Trigger.new)
    {
        if(a.ParentId != null)
        {
            ListAcc.add(a);
            idAcc.add(a.id);            
        }
    }
    
    List<Account> AccUltP = [select id, Name,
                                     ParentId,
                                     Parent.ParentId,
                                     Parent.Parent.ParentId,
                                     Parent.Parent.Parent.ParentId,
                                     Parent.Parent.Parent.Parent.ParentId                                     
                                     from 
                                        Account
                                     where 
                                        ParentId != null
                                        and
                                        id IN: idAcc];   
   if(AccUltP.size() > 0)
   {                                                                        
       for(Account a: ListAcc)
       {
        for(Account b: AccUltP)
        {           
            if(a.id == b.id)
            {
                if(b.Parent.Parent.Parent.Parent.ParentId != null)
                {
                    a.Ultimate_Parent__c = b.Parent.Parent.Parent.Parent.ParentId;
                }           
                else
                {
                    if(b.Parent.Parent.Parent.ParentId != null)
                    {
                        a.Ultimate_Parent__c = b.Parent.Parent.Parent.ParentId;
                    }       
                    else
                    {
                        if(b.Parent.Parent.ParentId != null)
                        {
                            a.Ultimate_Parent__c = b.Parent.Parent.ParentId;
                        }       
                        else
                        {
                            if(b.Parent.ParentId != null)
                            {
                                a.Ultimate_Parent__c = b.Parent.ParentId;
                            }       
                            else
                            {
                                if(b.ParentId != null)
                                {
                                    a.Ultimate_Parent__c = b.ParentId;
                                }
                                else
                                {
                                    a.Ultimate_Parent__c = b.id;
                                }                               
                            }                   
                        }               
                    }           
                }                   
            }
         }
      }
   }                                    
}