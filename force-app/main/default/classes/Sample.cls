public class Sample 
{ 
    public String state { get; set; }

    public List<User> usrs{get;set;}
    
    public Sample() 
    {    
        usrs = [SELECT ID, Name FROM User];
    }       
}