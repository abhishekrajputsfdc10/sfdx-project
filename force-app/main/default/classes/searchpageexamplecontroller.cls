public with sharing class searchpageexamplecontroller {

    public PageReference clearresult() {
        return null;
    }


Public List<Account> results{get;set;}

Public String searchStr{get;set;}
Public searchpageexamplecontroller()
{

results=new List<Account>();
}

Public PageReference doSearch()
{
String wcStr = '%'+searchStr+'%';
results=[Select id,name,type,industry from Account where Name like:wcStr];
return Null;
}

Public PageReference clearResults()
{
results.clear();
return Null;
}

Public Boolean getresultsAvailable()
{

return(results.size()>0);
}

}