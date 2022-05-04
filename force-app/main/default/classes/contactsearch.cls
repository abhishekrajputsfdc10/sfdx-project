public class contactsearch

{

public String searchfield { get; set; }

public list<contact> con { get; set; }

  public contactsearch(){

searchfield = null;

}

public void SearchAction(){

con =[select name,LeadSource from contact  where LeadSource =:searchfield limit 10];

  }

}