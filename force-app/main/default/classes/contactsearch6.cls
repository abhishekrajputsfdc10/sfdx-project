public class contactsearch6

{

public list<contact> con { get; set; }

public void SearchAction(){

con =[select name,LeadSource from contact limit 10];

  }

}