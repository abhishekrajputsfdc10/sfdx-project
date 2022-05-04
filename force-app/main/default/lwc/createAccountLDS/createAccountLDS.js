import { LightningElement, wire } from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';

const fieldsarray= ['Account.Name', 'Account.Phone', 'Account.Website'];

export default class CreateAccountLDS extends LightningElement {

    
    namejs;
    phonejs;
    websitejs;

    accountID;
    @wire(getRecord, {recordId: '$accountID', fields: fieldsarray})
    accountRecord;
    
    accountNameChangeHandler(event) {
        this.namejs = event.target.value;
    }

    accountPhoneChangeHandler(event) {
        this.phonejs = event.target.value;
    }

    accountwebsiteChangeHandler(event) {
        this.websitejs = event.target.value;
    }

     createAccount () {
        const fields = {'Name' : this.namejs, 'Phone' : this.phonejs, 'Website' : this.websitejs};
        const recordInput = {apiname : 'Account', fields};
        console.log('Paasing Account Value', recordInput);
        createRecord(recordInput).then(response => {
                       this.accountID = response.id;
                       console.log('Account has been created' +response.id);
                }).catch(error => {
                         console.error('Error in creating accunt:' , error.body.message);
        })    
    }

    get retAccountName () {
        console.log('accountRecord', this.accountRecord.data);
        console.log('Account ID', this.accountID);
        if(this.accountRecord.data) {
            return this.accountRecord.data.fields.Name.value;
        }
        return undefined;
    }

    get retAccountPhone () {
        if(this.accountRecord.data) {
            console.log('createdRecord', this.accountRecord.data.fields.Phone.value);
            return this.accountRecord.data.fields.Phone.value;
        }
        return undefined;
    }

    get retAccountWebsite () {
        if(this.accountRecord.data) {
            return this.accountRecord.data.fields.Website.value;
        }
        return undefined;
    }
}