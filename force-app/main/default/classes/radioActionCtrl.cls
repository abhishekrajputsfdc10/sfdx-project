public class radioActionCtrl {
    public Boolean disableInput {get; set;}
    public radioActionCtrl(ApexPages.StandardController controller) {
        disableInput = true;
    }    
    public void changeInputState(){
        disableInput = false;
    }
}