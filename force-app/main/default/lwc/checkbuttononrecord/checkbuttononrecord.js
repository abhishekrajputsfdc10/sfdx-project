import { LightningElement, api } from 'lwc';

export default class Checkbuttononrecord extends LightningElement {
    
    @api recordId;
    isTrue=false;
    handlemethod() {
        this.isTrue=true;
    }

    selecteccontactid;;

    handleevent(event) {
    this.selecteccontactid=event.detail;
    }

    handleSkip() {
        this.isTrue=false;
    }

}