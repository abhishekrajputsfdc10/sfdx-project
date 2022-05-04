import { LightningElement, api } from 'lwc';

export default class Callcustomlookup extends LightningElement {
    
    @api recordId;

    handleevent(event) {
        const test = event.detail;
        console.log('CatchEvent',test);
    }
   

}