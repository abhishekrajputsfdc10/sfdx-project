@isTest
Public class testcreate {
Public static  testmethod void test () {

List<Contact> lstcon = new List<Contact>();
For (Integer i=0; i<200;i++)
{
Contact con = new Contact(lastname='Name'+i);
lstcon.add(con);
}
Test.startTest();
insert lstcon;
Test.stopTest();


}

}