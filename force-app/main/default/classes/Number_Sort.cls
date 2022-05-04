public class Number_Sort {


    Public List<Account> lstacc = new List<Account>();
    
    Public Number_Sort() {
        
        lstacc = [Select name, Numeric__c from Account ORDER BY Numeric__c];
        
    }

}