public with sharing class cc {

Public List <Account> lstact {get;set;}

Public void Click() {
lstact = [Select Name From Account];
}

}