Public Class Testbatch
{

    public String myname { get; set; }

Public String cname {set;get;}

public void show ()
{
batchexample02 mybatch = new batchexample02(cname);

ID id = Database.executeBatch(mybatch,400);
}

}