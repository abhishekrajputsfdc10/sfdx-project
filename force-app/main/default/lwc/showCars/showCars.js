import { LightningElement, api, wire } from 'lwc';
import searchCars from '@salesforce/apex/searchCars.searchCars';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ShowCars extends LightningElement {
    @api carid;
         records;
    @wire(searchCars, {str: '$carid'})
    wiredrecords({data, error}) {
        if(data){
            console.log('Car ID', this.carid);
            this.records=data;
            console.log('Caresss', this.records);
        }
        if(error){
            this.showToast('ERROR', error.body.message,'error');
        }

    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}