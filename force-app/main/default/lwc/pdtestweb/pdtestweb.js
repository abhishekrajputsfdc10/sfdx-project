import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/Lwcsession.getAccounts';
//import refreshApex from '@salesforce/apex';

export default class Pdtestweb extends LightningElement {
    
    entervalue;
    accountdata;
    
    handlechange(event) {
         this.entervalue=event.target.value;
         console.log('this.entervalue', this.entervalue);
    }
    
    clickMethod() {
        getAccount()
        .then(result => {
             this.accountdata=result;
             console.log('this.accountdata', this.accountdata);
        })
        .catch(error => {
            console.log('Errro');
        });
    }
    
    

    //Wire Method
    /*@wire(getAccount, {accname : '$entervalue'})
    wiredAccount({data, error}) {
        if(data) {
             this.accountdata=data;
             console.log('this.accountdata', this.accountdata);
        } if(error) {
            console.log('Error')
        }
    } */

   

 




    // Wire method has two things=> property another is function
    // data and error


}