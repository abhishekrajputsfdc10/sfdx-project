trigger TestTrigger on Case (After insert, After update ) {

{
      if(trigger.isInsert)
    {
        for(case cs:trigger.new)
        {
        Web.callWebservice(cs.id);
        }
    }
}

}