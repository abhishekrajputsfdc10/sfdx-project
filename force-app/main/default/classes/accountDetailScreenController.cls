Public with sharing class accountDetailScreenController {
Public list<contact> conList{get;set;}
Public id CurrentAccountId;
Public boolean showCOntactFlag{get;set;}
    public accountDetailScreenController(ApexPages.StandardController controller) {
      CurrentAccountId = controller.getrecord().id;
      showCOntactFlag = false;
    }
   Public void fetchContacts(){  
     showCOntactFlag = true;
     conList = new List<contact>();
     conList = [select name,email,leadsource,Department,Description from contact where accountid =:CurrentAccountId];
   }
}