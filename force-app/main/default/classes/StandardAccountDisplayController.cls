public with sharing class StandardAccountDisplayController{ 
public List<Account> records {get; set;} 
public StandardAccountDisplayController(){ 
records = [select Name, Numeric__c from Account limit 10]; 
} 
}