import { LightningElement,wire } from 'lwc';
import getAccounts from '@salesforce/apex/utilityClassforLWC.getAccounts';

export default class UseWireMethod extends LightningElement {

    @wire(getAccounts) accounts;

}