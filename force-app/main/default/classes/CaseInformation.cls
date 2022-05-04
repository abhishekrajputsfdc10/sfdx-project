@RestResource(urlMapping='/CaseInformation')
global class CaseInformation
{   
    @HttpGet
    global static ResponseClass getRelatedCases()
    {
        String casesListResponse;
        String errorMessage;
        String emailId = RestContext.request.params.get('email');
        List<Contact> listContact = [SELECT Id, Name, Email FROM Contact WHERE Email =: emailId];
        List<Case> listCase = new List<Case>();
        ResponseClass varResp = new ResponseClass();
        if(listContact.size() > 0)
        {
            List<Case> listExistingCase = [SELECT Id, CaseNumber, Subject, Reason, Description, OwnerId, Owner.Name, Status FROM Case WHERE ContactId IN : listContact OR SuppliedEmail =: emailId];
            
            if(listExistingCase.size() > 0)
            {
                varResp.success = true;
                for(Case varCase : listExistingCase)
                {
                    varResp.listCases.add(new CaseInfo(varCase.CaseNumber, varCase.Subject, varCase.Description, varCase.Reason, varCase.Owner.Name));
                }
            }
            else
            {
                varResp.errorMessage = 'No cases found related to the Contact with provided Email ID';
            }
        }
        else
        {
            varResp.errorMessage = 'Contact with provided Email ID not found';
        }
        /* casesListResponse = JSON.serialize(varResp);
        return casesListResponse; */
        return varResp;
    }

    global class ResponseClass
    {
        boolean success;
        String errorMessage;
        List<CaseInfo> listCases;
        
        global ResponseClass()
        {
            this.success = false;
            this.errorMessage = '';
            this.listCases = new List<CaseInfo>();
        }
    }
    
    global class CaseInfo
    {
        String CaseNumber;
        String Subject;
        String Description;
        String CaseReason;
        String OwnerName;
             
        global CaseInfo(String CaseNumber, String Subject, String Description, String CaseReason, String OwnerName)
        {
            this.CaseNumber = CaseNumber;
            this.Subject = Subject;
            this.Description = Description;
            this.CaseReason = CaseReason;
            this.OwnerName = OwnerName;
           
    }
}
}