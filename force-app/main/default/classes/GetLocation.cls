public with sharing class GetLocation {
    
    @AuraEnabled(cacheable=true)
    public static string GetLocationmethod(string location) {
        
        string str = 'https://developers.zomato.com/api/v2.1/locations?query=' +location;
                   
        HttpRequest httpRequest = new HttpRequest();  
        httpRequest.setMethod('GET');   
        httpRequest.setHeader('user-key', '9313aaab0e24a703f8c8cba5ef96ee77');        
        httpRequest.setEndpoint(str);

        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);    
        system.debug('Test' +httpResponse.getBody());
        
        /*
        Method 1 without using the wrapper class
        Map<String, Object> map1 =  (Map<String, Object>)JSON.deserializeUntyped(httpResponse.getBody());
        system.debug('Map1' +map1);
        List<Object> locations =   (List<Object>)map1.get('location_suggestions');
        system.debug('Location' +locations);
        return locations;
        */

        
        /* 
        Method 2 without using the Parse method of wrapper class
        ZomatoLocation zomloc = (ZomatoLocation)JSON.deserialize(httpResponse.getBody(), ZomatoLocation.class);
        system.debug('Zom lo' +zomloc.location_suggestions);
        return zomloc.location_suggestions; 
        */
        
        // Method 3 using the parse method of wrapper class
        ZomatoLocation zomloc1 = ZomatoLocation.parse(httpResponse.getBody());
        return JSON.serialize(zomloc1.location_suggestions);
    }

    public static void getrestsearch(string location, string entityid, string entitytype) {

        string str = 'https://developers.zomato.com/api/v2.1/search?' +'entity_id='+entityid +'entitytype='+entitytype+ 'q='+location;

        HttpRequest httprequest = new HttpRequest();
        httprequest.setMethod('GET');
        httprequest.setHeader('user-key', '9313aaab0e24a703f8c8cba5ef96ee77');
        httpRequest.setEndpoint(str);

        Http http = new Http();
        HttpResponse httpresponse = http.send(httprequest);
        system.debug('Method 2' +httpresponse.getBody());
        

    }
}