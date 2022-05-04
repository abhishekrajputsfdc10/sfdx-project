public class ref2 {
public account a{get;set;}

public ref2(){
id id1=apexpages.currentpage().getparameters().get('id');
a=[select name,id,phone from account where id=:id1];
}

public pagereference acton(){
update a;
pagereference pr = new pagereference('/apex/ref3?id='+a.id);
return pr;
}

}