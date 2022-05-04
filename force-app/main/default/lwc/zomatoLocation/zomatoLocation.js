import { LightningElement, track, wire } from 'lwc';
import GetLocation from '@salesforce/apex/GetLocation.GetLocationmethod'

export default class ZomatoLocation extends LightningElement {

    seachlocation;
    title;
    entityid;
    entitytype;

    records;
   
    searchlocationhandler(event) {
        this.seachlocation=event.target.value;
    }

    //@wire(GetLocation, {loca  tion:'$seachlocation'})accounts;

    @wire(GetLocation, {location:'$seachlocation'})
    wiredContacts({ error, data }) {
        if (data) {
            console.log('search key:',this.seachlocation );
            console.log('Data', data);  
            this.records = JSON.parse(data);
            console.log('After Json', this.records.title);
            this.error = undefined;
            //this.seachlocation='Bangalore';
        } else if (error) {
            console.log('I am here', error.body.message);
            this.error = error;
            this.records = undefined;
        }
    }

    selectedvalue(event) {
        console.log('Tets', event.target.dataset.id);
        console.log('event.target.value', event.target.value);
        console.log('event.detail.value', event.detail.value);
        console.log('event.detail', event.detail);
        this.seachlocation=event.target.dataset.id;
    }

   

    /*handleclick() {
        GetLocation({ location: this.seachlocation})
        
        .then(result => {                           
            const output=JSON.parse(result);
            this.title=output[0].title;
            this.entityid=output[0].entity_id;
            this.entitytype=output[0].entity_type;
            console.log('TITLE', this.title,this.entityid,this.entitytype );            
          
        })
        .catch(error => {
               console.log('Error', JSON.stringify(error));
        });
    } */
}