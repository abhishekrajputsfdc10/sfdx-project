import { api, LightningElement, track, wire } from 'lwc';
import lookUp from '@salesforce/apex/ContactCustomLookup.getContcats';


export default class customLookUp extends LightningElement {

    iconName = "standard:contact";
    @api searchPlaceholder='Search';
    @api recordid;

    selectedName;
    records;
    isValueSelected;
    blurTimeout;
    isLoading=true;

    searchTerm;
    //css
    boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    inputClass = '';

    @wire(lookUp, {searchTerm : '$recordid'})
    wiredRecords({ error, data }) {
        if (data) {
            console.log('wire method', data);
            this.error = undefined;
            this.records = data;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }


    handleClick() {
        this.searchTerm = '';
        this.inputClass = 'slds-has-focus';
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
    }

    onBlur() {
        console.log('On Blur');
        this.blurTimeout = setTimeout(() =>  {this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'}, 300);
    }

    onSelect(event) {
        let selectedId = event.currentTarget.dataset.id;
        console.log('selectedId',selectedId);
        this.searchTerm=event.currentTarget.dataset.name;
        let selectedName = event.currentTarget.dataset.name;
        const valueSelectedEvent = new CustomEvent('lookupselected', {detail:  selectedId });
        this.dispatchEvent(valueSelectedEvent);        
        this.isValueSelected = true;
        this.selectedName = selectedName;
        if(this.blurTimeout) {
            clearTimeout(this.blurTimeout);
        }
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    }

    handleRemovePill() {
        this.isValueSelected = false;
        this.handleClick();
        this.searchTerm='';
        this.blurTimeout = setTimeout(() =>  {this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'}, 300);
    }

    onChange(event) {
        this.searchTerm = event.target.value;
        
    }

    @api callfromparent() {
        console.log('Calling from parent', this.isValueSelected);
        this.isValueSelected=false;
        this.searchTerm='';
    } 
   

}