trigger duplicatelead1 on Lead (before insert, before update) {

List<Lead> lstlead = [select id,email from Lead where email != null];
Set<String> str = new Set<String>();

For (Lead le : lstlead) {
str.add(le.email);
}
For (lead l : trigger.new){
If(str.contains(l.email)){
l.adderror('Dupe Lead');
}

}

}