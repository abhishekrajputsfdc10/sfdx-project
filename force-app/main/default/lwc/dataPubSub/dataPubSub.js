import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';
import getAccount from '@salesforce/apex/utilityClassforLWC.getAccounts';

export default class DataPubSub extends LightningElement {
     
    
    @wire(CurrentPageReference) pageRef;
    @wire(getAccount, {str:'$strkey'}) accounts;
    
    strkey;
    showData=true;
   connectedCallback(){
        console.log('underConnectedcallback', this.strkey);
        registerListener('searchvalue', this.handleEvent, this);
        
    }

    /*constructor(){
        super();
        console.log('underConnectedcallback', this.strkey);
        registerListener('searchvalue', this.handleEvent, this);
        
    } */

    handleEvent(strkey12) {
              console.log('I am doing tetsng', strkey12);
              this.strkey=strkey12;
             }

   disconnectedCallback(){
       console.log('Disconnect call');
        unregisterAllListeners(this);
    }

    
}