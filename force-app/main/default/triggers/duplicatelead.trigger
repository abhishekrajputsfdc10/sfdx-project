trigger duplicatelead on Lead (before insert, before update) {



List<String> lst = new List<String>();

for (Lead led : trigger.new)

{
lst.add(led.email);
}


List<Lead> lstlead = [select id,email from Lead where email in: lst];

for(Lead l : trigger.new){

            if(lstlead.size() > 0 )
                l.addError('Lead is already pre');

        }



}