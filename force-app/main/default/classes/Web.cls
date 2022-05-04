Public Class Web {
@Future (Callout = True)
Public static void callWebservice(Id CaseId)
    {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http  http   = new Http();

        req.setEndpoint('http://services.groupkt.com/country/get/iso2code/IN');
        req.setMethod('GET');
       // req.setBody('name='+EncodingUtil.urlEncode(name, 'UTF-8')+'&city='+EncodingUtil.urlEncode(city, 'UTF-8'));
        req.setCompressed(true); // otherwise we hit a limit of 32000

        try {
            res = http.send(req);
            System.debug('response from webservice==='+res);
            if(res.getStatuscode()==200)
           {
                System.Debug('response from web service====='+res.getBody());
                //System.Debug('response from web service====='+String.toString(res.getBody()));
                Case cs=[select id from case where id=:CaseId Limit 1];
                cs.Webresponse__c=res.getBody();
                update cs;
                
           }
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }
    }
    }