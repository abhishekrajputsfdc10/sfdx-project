public class SearchContact {
Public String search{get;set;}
public list<Contact> con{get;set;}

public SearchContact()

{
con = [SELECT id,name,LeadSource FROM Contact];

}

}