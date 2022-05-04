public class pg1 {

Public String pr {get;set;}
list<case> lstcase = [Select id, Priority From Case];
Public void upd() {
For (Case ca : lstcase){
ca.Priority = pr;
}
update lstcase;

}
}