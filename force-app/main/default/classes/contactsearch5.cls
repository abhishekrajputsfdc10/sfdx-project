public class contactsearch5{

    public PageReference SearchAction() {
        return null;
    }

List<Contact> con = new list<contact>();
public List<Contact> getSearchAction(){
con =[select name, LeadSource from contact limit 10];
return con;
}

}