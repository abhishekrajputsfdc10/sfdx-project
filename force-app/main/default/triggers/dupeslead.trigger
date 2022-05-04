trigger dupeslead on Lead (before insert, before update) {

map<id,string> map1 = new map<id,string>();


for (Lead l : trigger.new)

{
map1.put(l.id,l.email);


}

for(Lead le : trigger.new)

{
system.debug(map1.get(le.ID));



}

}