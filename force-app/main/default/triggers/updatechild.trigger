trigger updatechild on Account (Before update)
{
Map<id,String> map1 = new map<id,String>();

for (Account a : trigger.new)
{
map1.put(a.parentid,a.name);
}


}