public class Acc {
Public List<Account> lstacc {get;set;}
Public void m1() {
lstacc = [Select id, Name From Account];
}

}