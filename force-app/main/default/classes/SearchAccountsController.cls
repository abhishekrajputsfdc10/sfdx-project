/*******************************************************************
 * Custom controller for the "Form Based Searching" recipe.
 * Executes a search via SOQL based on the fields the user has 
 * entered on the associated Visualforce page.
 *******************************************************************/
public with sharing class SearchAccountsController 
{
    // the search results
    public List<Account> results { get; set;}
    
    // the account instance to capture the search criteria
    public Account searchAcc {get; set;}
    
    // the industry picklist options to allow selection of more than one
    
    // the chosen industries
    
    
    // constructor
    public SearchAccountsController()
    {
        
        searchAcc=new Account();
    }
    
    // determine the industry options by interrogating the schema
       
    // action method to search for accounts matching the criteria
    public PageReference executeSearch()
    {
        if (null!=results)
        {
            results.clear();
        }
        String whereStr='';
        
        // only add a name clause if the user has entered some text
        if (!String.IsEmpty(searchAcc.Name))
        {
            String wcName='%' + searchAcc.Name + '%';
            whereStr+=' OR Name LIKE \'' + wcName + '\'';
        }
        
        // only add a website clause if the user has entered some text
        if (!String.IsEmpty(searchAcc.Website))
        {
            String wcWebsite='%' + searchAcc.Website + '%';
            whereStr+=' OR Website LIKE \'' + wcWebsite + '\'';
        }
        
        // only add an industries clause if the user has selected one or more
                
        // only execute a search if the user entered some criteria
        if (''!=whereStr)
        {
            String queryStr='select Id, Name, Website, Industry from Account where ' + whereStr.substring(4);
            results=Database.query(queryStr);
        }
        
        return null;
    }
}