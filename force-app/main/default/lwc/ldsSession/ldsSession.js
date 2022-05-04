import { LightningElement, api, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import {createRecord} from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';

export default class LdsSession extends LightningElement {
   
    testval;
    phonevalue;
    @api recordId;
    testdata;
    accountvalue;
    phonevalue;
    
    accountid;
    accountnamehandler(event) {
        this.accountvalue=event.target.value;
    }
    
    accountphonehandler(event) {
        this.phonevalue=event.target.value;
    }

    saveAccount() {
        //console.log('Saving Account');
       const fields = {};
       fields[ACCOUNT_NAME.fieldApiName] = this.accountvalue;
       fields[ACCOUNT_PHONE.fieldApiName] = this.phonevalue;
      // console.log({fields});
       const recordInput = {apiName:ACCOUNT_OBJECT.objectApiName, fields};
       //console.log({recordInput});
        createRecord(recordInput)
           .then(result => {
             this.accountid=result.id;
             console.log('this.accountid', this.accountid);
           })
           .catch(error => {
            console.log('Error', error.body.message);
           });
    }

   @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
   objectinfo({data, error}) {
       if(data) {
         this.testdata=data;
         console.log('this.testdatathis.testdata', this.testdata);
       } if (error) {
           console.log('Error', error.body.message);
       }
   }

   get recordtypeId() {
       const recordtype = this.testdata.recordTypeInfos;       
   }

    /*successMethod(event) {
        
        const recordid = event.detail.id;
        console.log({recordid});
    }

    submitMethod(event) {
        event.preventDefault();
        const fields=event.detail.fields;
        console.log('000fields', fields.Phone);
        fields.Phone="123";      
        this.template.querySelector('lightning-record-edit-form').submit(fields);  
       
    }

    phonechange(event) {
       this.phonevalue=event.target.value;
    } */
}