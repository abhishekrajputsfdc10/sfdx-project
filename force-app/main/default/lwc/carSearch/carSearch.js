import { LightningElement } from 'lwc';

export default class CarSearch extends LightningElement {
    
    carid;
    handleevent(event){
        this.carid = event.detail;
        console.log('event capture', this.carid);
    }
}