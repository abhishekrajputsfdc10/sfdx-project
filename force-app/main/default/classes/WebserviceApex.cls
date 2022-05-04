@RestResource(urlMapping='/Accounts/*')
global with sharing class WebserviceApex {
    @HttpGet
    global static List<Account> getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        List<Account> result =  [SELECT id, Name
                        FROM Account
                        ];
        return result;
    }
}