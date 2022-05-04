import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class SearchPubSub extends LightningElement {
    
    @wire(CurrentPageReference) pageRef;
    searchKey; 

    searchHandle(event) {
        this.searchKey=event.target.value;
        console.log('here', this.searchKey);
        //event.preventDefault();
        fireEvent(this.pageRef, 'searchvalue', this.searchKey);
        console.log('Test', this.searchKey);
    }

}