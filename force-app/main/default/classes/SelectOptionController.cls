public class SelectOptionController {

   public List<SelectOption> countrieLst {get;set;}
   public String selectedCountry{get;set;}
        public SelectOptionController(ApexPages.StandardController controller){
     countrieLst = new List<SelectOption>();
          countrieLst.add(new SelectOption('',''));
          countrieLst.add(new SelectOption('UP','UP'));
          countrieLst.add(new SelectOption('Karnataka','Karnataka'));
          countrieLst.add(new SelectOption('AP','AP'));          
          }    
          
          }