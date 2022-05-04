import { LightningElement,wire } from 'lwc';
import getcartype from '@salesforce/apex/carTypeSearch.getCarType'

export default class CarSearchComponent extends LightningElement {
        
     carTypes;
     error;
     
     @wire(getcartype)
     wiredrecords({data, error}) {
       if(data) {
        this.carTypes=[{ value: '', label: 'All Types' }];  
        data.forEach(element => {
          const carType = {};
          carType.value=element.Id;
          carType.label=element.Name;
          this.carTypes.push(carType);
        });
        console.log('Car Type', this.carTypes);
        
       }
       if(error) {
         this.error=error;
       }
     }

     handleChange(event) {
       const carTypeID = event.detail.value;

       const carTypeSelectionChangeEvent = new CustomEvent('cartypechange', {detail: carTypeID});
       this.dispatchEvent(carTypeSelectionChangeEvent);
     }
     
}