Public Class Pagerefrencetest {

Public Pagerefrencetest() {

}
     Public pageReference Test() {
       PageReference pg = new PageReference('/apex/searchaccounts');
       pg.setRedirect(true);
       return pg;
     
     }


}