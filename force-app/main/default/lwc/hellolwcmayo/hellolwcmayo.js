import { LightningElement, wire } from 'lwc';
import handleAccout from '@salesforce/apex/TestMayo.handleAccout';

export default class Hellolwcmayo extends LightningElement {

    testdata;
    inputRead;
    @wire(handleAccout)
    wiredAccount({data, error}) {
        if(data) {
            console.log('DATA', data);
            this.testdata=data;
            console.log('this.testdata',this.testdata);
        } if (error) {
            console.log('Error');
        }
    }

    /*Hello = 'helloMayo';
    inputRead;
    clickme;
    textvalue;
    

    handlechange(event) {        
        this.inputRead=event.target.value;
        console.log(' this.inputRead',this.inputRead);
        this.textvalue=this.inputRead;
    }

    /*constructor() {
        super();
        this.inputRead='Test';
        console.log('I am in constructor');
    }

    connectedCallback() {
        this.inputRead='input';
        console.log('i AM CONNECTEDCALLBACK');
    }

    clickmefunc() {
        this.inputRead='after clickl';
    } */



}