public class Account_Sort {
    
        //wrapperList variable 
    public List<wrapperClass> wrapList{get;set;}
    
    //constructor to load the wrapperList
    public Account_Sort(){
        
        wrapList = new List<wrapperClass>();
        
        for(Account ac : [select name from account LIMIT 5]){
            
            wrapperClass temp= new WrapperClass();
            temp.ac = ac;
            temp.num=0;
            wrapList.add(temp);
        }
    
    }
    
    public void sortAccount(){
        try{    
            system.debug('inside sort');
            wrapperClass temp = new wrapperClass();
            for(Integer i = 0 ; i < wrapList.size() ; i ++) {
                for(integer j = i+1 ; j <= wrapList.size() -1 ; j ++ ){
                     temp = new wrapperClass(); 
                     if(wrapList[i].num >  wrapList[j].num){
                          
                        temp = wrapList[i] ;
                        wrapList[i] = wrapList[j]  ;
                        wrapList[j] = temp;
                        system.debug(wrapList) ;
                      }
                }
            }
        }    
        catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));

        }
 
    }
        
    //wrapper Class 
    public class wrapperClass{
        
        public account ac{get;set;}
        public Integer num{get;set;}
        
    }


}