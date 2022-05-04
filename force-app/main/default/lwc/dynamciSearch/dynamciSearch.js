import { LightningElement, wire } from 'lwc';
import getaccout from '@salesforce/apex/utilityClassforLWC.getAccounts'

export default class DynamciSearch extends LightningElement {
    searchKey;
    isCheck=false;
    
    @wire(getaccout, {str:'$searchKey'})accounts;

    searchHandler(event){
        this.searchKey=event.target.value;
        //isCheck=false;
        console.log('Search Key is:',this.searchKey);
        if(this.searchKey!='' || this.searchKey!=null) {
            this.isCheck=true;
        } else{
            isCheck=false;
        }
        
    }

    onSelect(event) {
        console.log(event.target.dataset.id);
        this.searchKey=event.target.dataset.id;
    }
}