public with sharing class UserInf {
    
    @AuraEnabled
    Public static User fetchUser(){
        User us = [Select id, Name from User];
        return us;
    }

}