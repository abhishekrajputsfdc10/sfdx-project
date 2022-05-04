import { LightningElement, track} from 'lwc';

export default class testProperty extends LightningElement {
   @track cardTitle = 'BMI Calculator';
   testingvar = [{Name : 'test', Age : '28'}];

    changePrivatePropertyValue(){
        this.cardTitle = 'Changed value';
        //this.testingvar = [{Name : 'test', Age : '32'}];
        this.testingvar.Name = 'Ram';
        this.testingvar.Name = '30';
        console.log('value: ', this.cardTitle);
        console.log('value: ', this.testingvar);
    }
}