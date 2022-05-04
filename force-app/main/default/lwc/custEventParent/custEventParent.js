import { LightningElement} from 'lwc';

export default class CustEventParent extends LightningElement {
    messageFrmChild;

    handelMessageFromChild(event) {
        console.log('teting', event.detail);
        this.messageFrmChild=event.detail;
    }
}