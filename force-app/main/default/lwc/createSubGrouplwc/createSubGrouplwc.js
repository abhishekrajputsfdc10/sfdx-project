import { LightningElement, api, track, wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import GetLocation from '@salesforce/apex/GetLocation.GetLocationmethod';
import SUBGROUP_OBJECT from '@salesforce/schema/Sub_Group__c';
import ACCOUNT_ID from '@salesforce/schema/Sub_Group__c.Account__c';
import SUBGROUP_NAME from '@salesforce/schema/Sub_Group__c.Name';


/*const columns = [
    { label: 'Subgroup', fieldName: 'name' },
    { label: 'Service Level', fieldName: 'website'},
    ]; */

   
export default class CreateSubGrouplwc extends LightningElement {
    @api recordId;  
    @api objectName;
    records;
    name='';
    handle(event) {
        console.log('Here');
    }
   
        searchlocationhandler(event) {
        console.log('event.target.value', event.target.value)
        this.seachlocation=event.target.value;
        console.log('this.seachlocation', this.seachlocation)
    }
    getsubname(event) {  
       this.name=event.target.value;
    }

    handleaccount(event) {
        this.recordId=event.target.value;
    }
    

    createAccount() {
        const fields = {};
        fields[SUBGROUP_NAME.fieldApiName] = this.name;
        fields[ACCOUNT_ID.fieldApiName] = this.recordId;
        const recordInput = { apiName: SUBGROUP_OBJECT.objectApiName, fields };
        createRecord(recordInput)
            .then(subgroup => {
                console.log('Result - >', subgroup.id);
                //this.accountId = account.id;
            })
            .catch(error => {
                console.log('ERROR', error.body.message);
               
            });
    }

    savehandle() {

    }

    @wire(GetLocation, {location:'$seachlocation'})
    wiredContacts({ error, data }) {
        if (data) {
            console.log('search key:',this.seachlocation );
            console.log('Data', data);  
            this.records = JSON.parse(data);
            console.log('this.records', this.records);
            this.error = undefined;
            //this.seachlocation='Bangalore';
        } else if (error) {
            console.log('I am here', error.body.message);
            this.error = error;
            this.records = undefined;
        }
    }

    selectedvalue(event) {
        console.log('Tets', event.target.dataset.id);
        console.log('event.target.value', event.target.value);
        console.log('event.detail.value', event.detail.value);
        console.log('event.detail', event.detail);
        this.seachlocation=event.target.dataset.id;
    }
    
    closeQuickAction() {
        const closeQA = new CustomEvent('close');
        // Dispatches the event.
        this.dispatchEvent(closeQA);
    }
    /*testthis;
    columns = columns;
    data=[];
    handleclick() {
       // this.data=[];
       var testthis=this;
       this.data.push(
        {name : 'Test',
        website : '7'},
        {name : 'Test2',
        website : '4'}
       );
       testthis.data=this.data;
    console.log('data', this.data);
    } */
}