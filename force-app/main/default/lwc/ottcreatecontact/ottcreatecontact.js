import { LightningElement, api, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import OTT_OBJECT from '@salesforce/schema/OTT_Contact__c';
import ACCOUNT_FIELD from '@salesforce/schema/OTT_Contact__c.Account__c';
import CONTACT_FIELD from '@salesforce/schema/OTT_Contact__c.Contact__c';
import { publish, MessageContext } from 'lightning/messageService';
import Sample from '@salesforce/messageChannel/Sample__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Ottcreatecontact extends LightningElement {

    conid;
    @api recordid;
    error;
    
    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        console.log('recordidrecordid', this.recordid);
    }

    


    handleevent(event) {
        this.conid=event.detail;
    }
    ottrecordid;

    createOTTContact() {
        console.log('this.conidthis.conid',this.conid);
        console.log('recordidrecordid',this.recordid);
        const fields={};
        fields[ACCOUNT_FIELD.fieldApiName] = this.recordid;
        fields[CONTACT_FIELD.fieldApiName] = this.conid;
        const recordInput = { apiName: OTT_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(result => {
                this.ottrecordid = result.id;
                this.template.querySelector("c-custom-Look-Up").callfromparent(); 
                console.log('this.ottrecordid', this.ottrecordid);
                const payload = {ottId: this.ottrecordid};
                console.log('payloadpayload',payload);
                publish(this.messageContext,Sample, payload);
            })
            .catch(error => {   
                console.log('errorerror',error);
                error.body.output.errors.forEach(element => {
                    this.error=element.message;
                    console.log('element', element.message);
                });
                
                
                    const event = new ShowToastEvent({
                        title: 'Toast message',
                        message: this.error,
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(event);
                

            });         
    }


}