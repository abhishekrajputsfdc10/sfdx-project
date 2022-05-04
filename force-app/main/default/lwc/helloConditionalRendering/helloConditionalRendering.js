import { LightningElement, track } from 'lwc';

export default class HelloConditionalRendering extends LightningElement {

    @track areDetailsVisible = true;

    handleChange (event) {
        this.areDetailsVisible = event.target.checked;
    }
}