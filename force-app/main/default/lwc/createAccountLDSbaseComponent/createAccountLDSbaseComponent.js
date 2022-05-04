import { LightningElement } from 'lwc';

export default class CreateAccountLDSbaseComponent extends LightningElement {
    recordID;
    handleClick(event) {
        console.log('I am here');
        this.recordID = event.detail.id;
        console.log('Created Account', this.recordID);
    }

    checkValidation(event) {
        event.preventDefault();
        const fields = event.detail.fields;
        if(fields.Phone!='' && fields.Phone!=null) {
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }else {
            alert('Error');
        }
        //this.template.querySelector('lightning-record-edit-form').fields.Name;
    }

}