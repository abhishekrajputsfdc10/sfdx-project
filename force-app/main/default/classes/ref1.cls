public class ref1 {

public account a{get;set;}

public ref1(){
a=new account();
}
public pagereference insrt(){
insert a;
pagereference pr = new pagereference('/apex/ref2?id='+a.id);
return pr;
}

}