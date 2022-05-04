public with sharing class currentUserInfoCtrl  {
    
    @AuraEnabled
    Public static User fetchUser () {
        
        User oUser = [select id,Name,TimeZoneSidKey,Username,Alias,Country,Email,FirstName,LastName,IsActive,IsPortalEnabled 
                      FROM User 
                      Where id =: userInfo.getUserId()];
                      
        return oUser;
    }

}