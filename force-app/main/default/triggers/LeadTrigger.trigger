trigger LeadTrigger on Lead (before update) {
    List<Attachment> listAttachments = new List<Attachment>();
    List<Attachment> listInsertAttachments = new List<Attachment>();
    set<Id> leadIds = new set<Id>();
    
    for(Lead l : trigger.new) {
        if(l.isConverted) {
            leadIds.add(l.Id);
        }
    }
    
    if(leadIds.size() > 0) {
        listAttachments = [SELECT Name, Body, ParentId FROM Attachment WHERE ParentId IN: leadIds];
        
        if(listAttachments.size() > 0) {
            for(Attachment a : listAttachments ) {
                Attachment newAttachment = a.clone();
                newAttachment.ParentId = trigger.newMap.get(a.ParentId).ConvertedAccountId;
                listInsertAttachments.add(newAttachment);
            }
            
            insert listInsertAttachments;
        }
    }
}