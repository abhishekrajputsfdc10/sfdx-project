public class CaseInformation1
{
    public DeserializedCases deserializedResponse;
    private final Contact currContact;
    Map<String, CaseInfo> mapCaseNumber_CaseDetails;
    public CaseInfo singleCase {get; set;}
    public boolean dispSingleCaseFlag {get; set;}
    public List<CaseInfo> externalCases 
    {
        get
        {
            return mapCaseNumber_CaseDetails.values();
        }
        set;
    }
    
    public CaseInformation1(ApexPages.StandardController controller)
    {
        deserializedResponse = new DeserializedCases();
        this.currContact = (Contact)controller.getRecord();
        //externalCases = new List<CaseInfo>();
        mapCaseNumber_CaseDetails = new Map<String, CaseInfo>();
        dispSingleCaseFlag = false;
        getCaseInformation(currContact.Email);
    }
    
    private HTTPResponse oauthLogin(String loginUri, String clientId, String clientSecret, String username, String password) 
    {
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');
        req.setEndpoint(loginUri + '/services/oauth2/token');
        req.setBody('grant_type=password' + '&client_id=' + clientId + '&client_secret=' + clientSecret + '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') + '&password=' + EncodingUtil.urlEncode(password, 'UTF-8'));
    
        Http http = new Http();  
        HTTPResponse res = http.send(req);

        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());

        return res;
    }
    
    public void getCaseInformation(String email)
    {
        String accessToken, instanceUrl;
        // use <a href="https://test.salesforce.com" target="_blank" rel="nofollow">https://test.salesforce.com</a> for sandbox orgs
        //JSONObject oauth = oauthLogin('https://login.salesforce.com', 'YOUR_REMOTE_ACCESS_APP_CONSUMER_KEY', 'YOUR_REMOTE_ACCESS_APP_CONSUMER_SECRET', 'USERNAME_IN_TARGET_ORG', 'PASSWORD_IN_TARGET_ORG');
        HTTPResponse oauthResponse = oauthLogin('https://test.salesforce.com', '3MVG9ZL0ppGP5UrBbHk45YAjZq_FeB6aDFsF1kiUPPg8aCeE3XRhrXxxOfRokcHpp20IcJrqpwxfjfpCNNnmp', '2525547501987817920', 'nikhil.verma@mheducation.com.dev', 'Everest@123ss00Ta0NE9YM4BoIgGrV0j8YB');

        // Parse JSON response to get the access token
        JSONParser parser = JSON.createParser(oauthResponse.getBody());
        while(parser.nextToken() != null) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'access_token')
            {
                parser.nextToken();
                accessToken = parser.getText();
            }
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'instance_url')
            {
                parser.nextToken();
                instanceUrl = parser.getText();
            }
        }

        HttpRequest req = new HttpRequest(); 
 
        req.setMethod('GET');
        req.setEndpoint(instanceUrl+'/services/apexrest/CaseInformation?email='+email);
        req.setHeader('Authorization', 'OAuth '+accessToken);

        Http http = new Http();
  
        HTTPResponse res = http.send(req);

        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
        deserializedResponse = deserializedResponse.parse(res.getBody());
        system.debug('deserializedResponse-----' + deserializedResponse);
        if(deserializedResponse.success == false)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, deserializedResponse.errorMessage));
        }
        else
        {
            //externalCases.addAll(deserializedResponse.listCases);
            for(CaseInfo varCase : deserializedResponse.listCases)
                mapCaseNumber_CaseDetails.put(varCase.CaseNumber, varCase);
        }
    }
    
    public pageReference displaySingleCase()
    {
        String caseNum = ApexPages.currentPage().getParameters().get('caseNumber');
        singleCase = mapCaseNumber_CaseDetails.get(caseNum);
        dispSingleCaseFlag = true;
        return null;
    }
    
    public pageReference backToList()
    {
        dispSingleCaseFlag = false;
        return null;
    }
    
    public class DeserializedCases
    {
        boolean success;
        String errorMessage;
        List<CaseInfo> listCases;
        
        public DeserializedCases parse(String json) 
        {
            return (DeserializedCases) System.JSON.deserialize(json, DeserializedCases.class);
        }
    }
    
    public class CaseInfo
    {
        public String CaseNumber {get; set;}
        public String Subject {get; set;}
        public String Description {get; set;}
        public String CaseReason {get; set;}
        public String OwnerName {get; set;}
        public String Status {get; set;}
        public String Country {get; set;}
        public String ContactType {get; set;}
        public String SupportAccount {get; set;}
        public String Product {get; set;}
        public String Incident {get; set;}
        public String SubIncident {get; set;}
        public String OtherProduct {get; set;}
        public String Version {get; set;}
        public String URLWebsiteAddress {get; set;}
        public String SuppliedEmail {get; set;}
        public String CaseResolution {get; set;}
        
        public CaseInfo(String CaseNumber, String Subject, String Description, String CaseReason, String OwnerName, String Status, String Country, String ContactType, String SupportAccount, String Product, String Incident, String SubIncident, String OtherProduct, String Version, String URLWebsiteAddress, String SuppliedEmail, String CaseResolution)
        {
            this.CaseNumber = CaseNumber;
            this.Subject = Subject;
            this.Description = Description;
            this.CaseReason = CaseReason;
            this.OwnerName = OwnerName;
            this.Status = Status;
            this.Country = Country;
            this.ContactType = ContactType;
            this.SupportAccount = SupportAccount;
            this.Product = Product;
            this.Incident = Incident;
            this.SubIncident = SubIncident;
            this.OtherProduct = OtherProduct;
            this.Version = Version;
            this.URLWebsiteAddress = URLWebsiteAddress;
            this.SuppliedEmail = SuppliedEmail;
            this.CaseResolution = CaseResolution;
        }
    }
}