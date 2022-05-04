import { LightningElement, wire, track } from 'lwc';
import getAlltheObjects from '@salesforce/apex/getAllObjects.getAllCustomSObjects';

const DELAY = 300;

export default class DisplayalltheObject extends LightningElement {
    @track options = [];
    selectedvalue;
    
    @wire(getAlltheObjects)
    wiredobjects({data, error}) {
        if(data) {
            this.objects=data;
            this.options=[{ value: '', label: 'All Types' }];
             data.forEach(element => {
                 const obj={};
                 obj.label = element.MasterLabel;
                 obj.value = element.QualifiedApiName;
                 this.options.push(obj);
             });
             
        }
    }

    handleChange(event) {
        this.selectedvalue=event.detail.value;
        this.template.querySelector('c-displayallthe-fields').handlechange1();
    }
}