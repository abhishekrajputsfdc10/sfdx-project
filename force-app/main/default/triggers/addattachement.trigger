trigger addattachement on Contact (after insert, after update)  {    
    List<Attachment> listAttachments = new List<Attachment>();
    for(Contact e : trigger.new) {   
        Attachment a = new Attachment();
        a.ParentId = e.Id;
        a.Name = e.Name + Date.Today();
        a.ContentType = 'text/plain';
        a.Body = Blob.valueOf(e.Name + ' is added successfully');
        listAttachments.add(a);
    }
    insert listAttachments;
}