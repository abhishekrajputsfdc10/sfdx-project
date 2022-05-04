import { LightningElement } from 'lwc';

export default class CustEvent extends LightningElement {
    test;
    pressMe(event) {
        this.test='I have cliecked';
        const myCustomEvent=new CustomEvent("displaymessage", {detail : this.test});
        this.dispatchEvent(myCustomEvent);
    }

}