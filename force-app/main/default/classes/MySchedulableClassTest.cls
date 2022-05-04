@istest
class MySchedulableClassTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		MySchedulableClass testsche = new MySchedulableClass();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
	}
}