public class TableController{
 public List<Account> accList{get;set;}

 public TableController(){
  accList= new List<Account>();
  accList= [select id,name,type,industry from Account];
 }
}