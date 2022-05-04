@isTest
Public Class duplicatelead {

Static Testmethod void Dupe(){

List<Lead> lst = new List<Lead>();

For (Integer i=0;i<200;i++)
{

Lead l1 = new Lead(Lastname='Name'+i, Company='Dell', email='a@gmail.com');
lst.add(l1);
}
insert lst;
}

}