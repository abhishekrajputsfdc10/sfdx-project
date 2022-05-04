import {
    LightningElement,
    wire,
    track,
    api
} from 'lwc';
 
//import method from the Apex Class
import fetchAccounts from '@salesforce/apex/dataTableLWC.fetchAccounts';
import deletecon from '@salesforce/apex/dataTableLWC.deletecon';
import { refreshApex } from '@salesforce/apex';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import Sample from '@salesforce/messageChannel/Sample__c';

//datatable;
// Declaring the columns in the datatable

const columns = [
   /* {
        label: 'Contact',
        fieldName: 'Name'
    }, */

    {
        label: 'OTT Name',
        fieldName: 'recordLink',
        type: 'url',
        typeAttributes: {label: { fieldName: 'Name'}, 
        target: '_top'},
        sortable: true
    },

    { 
        label: 'Contact Name', fieldName: 'ContactUrl', wrapText: true,
        type: 'url',
        typeAttributes: {
            label: { 
                fieldName: 'ContactName' 
            },
            target : '_blank'
        } 
    },
    

    {
        label: 'Delete',
        type: 'button-icon',
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:delete',
            title: 'Preview',
            variant: 'border-filled',
            alternativeText: 'View'
        }
    }
];
 
// declare class to expose the component
export default class DataTableComponent extends LightningElement {
   
    conid;
    deletecontacts;
    @track columns = columns;
    @track record = {};
    @track rowOffset = 0;
    @track data = {};
    @track bShowModal = false;
    oppList = [];
    error;

    wireconresult;

    @api recordid;

    /*@wire(fetchAccounts)  
    parameters({ error, data }) {
   if (data) {
       this.wireconresult = data;
       console.log('this.wireconresultthis.wireconresult',this.wireconresult);
    var tempOppList = [];  
    for (var i = 0; i < data.length; i++) {
        console.log('I am here', i);
     let tempRecord = Object.assign({}, data[i]); //cloning object  
     console.log('tempRecordtempRecord', tempRecord);
     //tempRecord.recordLink = "/" + tempRecord.Contact__r.Name;
     tempRecord.recordLink = "/" + tempRecord.Id;
     //tempRecord.conlink = "/" + tempRecord.Contact__r.Id;
     tempRecord.ContactName = tempRecord.Contact__r.Name;
     tempRecord.ContactUrl = "/" + tempRecord.Contact__r.Id;
     console.log('tempRecordtempRecord', tempRecord);
     tempOppList.push(tempRecord);  
    } 
    this.oppList = tempOppList;  
    this.error = undefined;  
   } else if (error) {
    this.error = error;  
    this.oppList = undefined;  
   }
  } */
  connectedCallback() {
      console.log('DataTablerecordId', this.recordid);
  }
  @wire(fetchAccounts, {str: '$recordid'})  
    parameters(result) {
        console.log('thisrecordid', this.recordid);
       console.log('resultresult', result);
       this.wireconresult = result;
       console.log('this.wireconresultthis.wireconresult',this.wireconresult);
	   if (result.data) {
    var tempOppList = [];  
    for (var i = 0; i < result.data.length; i++) {
        console.log('I am here', i);
     let tempRecord = Object.assign({}, result.data[i]); //cloning object  
     console.log('tempRecordtempRecord', tempRecord);
     //tempRecord.recordLink = "/" + tempRecord.Contact__r.Name;
     tempRecord.recordLink = "/" + tempRecord.Id;
     //tempRecord.conlink = "/" + tempRecord.Contact__r.Id;
     tempRecord.ContactName = tempRecord.Contact__r.Name;
     tempRecord.ContactUrl = "/" + tempRecord.Contact__r.Id;
     console.log('tempRecordtempRecord', tempRecord);
     tempOppList.push(tempRecord);  
    } 
    this.oppList = tempOppList;  
    this.error = undefined;  
   } else if (result.error) {
    this.error = result.error;  
    this.oppList = undefined;  
   }
  }


    //@wire(fetchAccounts)parameters;
    subscription = null;
    textid;
    // Row Action event to show the details of the record
    handleRowAction(event) {
        const row = event.detail.row;
        this.record = row;
        this.conid = this.record.Id;
        console.log('rowrow', row);
        console.log('this.recordthis.record', this.record.Id);
        this.bShowModal = true; // display modal window
    }

    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel() {
        console.log('Subscribe');
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                Sample,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

   connectedCallback() {
        this.subscribeToMessageChannel();
    }


    handleMessage(message) {
        return refreshApex(this.wireconresult);   
    }
 
    // to close modal window set 'bShowModal' tarck value as false
    closeModal() {
        this.bShowModal = false;
    }

    handleCancel() {
        this.bShowModal = false;
    }

    handleNext() {
        deletecon({str: this.conid})
         .then((result) => {
            this.bShowModal = false;
            console.log('eleted record1234');
            //return refreshApex(this.parameters);
            return refreshApex(this.wireconresult);           
         }         
         )
         .catch((error) => {
            console.log('ERROR', error.body.message);
         });        
    }
}