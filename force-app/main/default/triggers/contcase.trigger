trigger contcase on contact (after update){
    
    list<contact> lst1 = new list<contact>();
    map<id,contact> mp1 = new map<id,contact>();
    
    for(contact c : trigger.new){
        lst1.add(c);
        mp1.put(c.id,c);
    }


list<case> lst2 = [select ownerid,contactid,id from case where contactid IN : lst1];

    for(case c :  lst2){
    c.ownerid = mp1.get(c.contactid).ownerid;
    
    }
    
   update lst2; 
}