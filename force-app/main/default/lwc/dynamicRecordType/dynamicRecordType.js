import { LightningElement, api, wire, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Contact';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class DynamicRecordType extends LightningElement {

    
    @api objectname;
    @track options = [];
       
    @wire(getObjectInfo, { objectApiName: '$objectname' })
    accObjectInfo({data, error}) {
        if(data) {
           let optionsValues = [];
            // map of record type Info
            const rtInfos = data.recordTypeInfos;
            console.log('Record Type123',rtInfos );

            // getting map values
            let rtValues = Object.values(rtInfos);

            for(let i = 0; i < rtValues.length; i++) {
                if(rtValues[i].name !== 'Master') {
                    optionsValues.push({
                        label: rtValues[i].name,
                        value: rtValues[i].recordTypeId
                    })
                }
            }

            this.options = optionsValues;
            //this.options.sort(this.sortByProperty('label'));
        }
        else if(error) {
            console.log('Error', error.message.body);
            window.console.log('Error ===> '+JSON.stringify(error));
        }
    }
     
    // Handling on change value
    handleChange(event) {
        this.selectedValue = event.target.value;
    }
}