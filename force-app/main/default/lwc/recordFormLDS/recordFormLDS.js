import { LightningElement } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class RecordFormLDS extends LightningElement {
    fieldsArray=[NAME_FIELD, PHONE_FIELD, WEBSITE_FIELD];
    recordId;

    handleclick(event) {
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        fields.Website = 'https:fb.com'; // modify a field
        this.template.querySelector('lightning-record-form').submit(fields);
    }

}