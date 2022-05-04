trigger prebentdelete on Account (before delete) {

for (Account a : trigger.old)
{
a.adderror('u cant delete');
}

}