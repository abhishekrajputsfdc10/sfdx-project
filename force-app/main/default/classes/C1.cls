public class C1 {
Public Account a {get;set;}

Public c1() {
a=new account();
}

Public Pagereference submit() {
insert a;
Pagereference pr = new Pagereference('/apex/vf2?id='+a.id);
return pr;

}
}