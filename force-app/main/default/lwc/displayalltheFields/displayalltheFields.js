import { LightningElement, api, wire, track } from 'lwc';
import retreieveRecords from '@salesforce/apex/getAllObjects.retreieveRecords';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import {refreshApex } from '@salesforce/apex';

export default class DisplayalltheFields extends LightningElement {

    @api selectedobjecttofetchfield;
    datatable;
    displaydata = {};
        
    commasepratedfields = '';

    @track columns = [
        { label: 'FieldName', fieldName: 'name', type: '' },
        { label: 'FieldAPIName', fieldName: 'FieldAPIName', type:''},
        { label: 'type', fieldName: 'type'}
        
    ];

    columnsrecords=[];
        
    
    @wire(getObjectInfo, {objectApiName: '$selectedobjecttofetchfield'})
    wiresrecords({data, error}) {
        if(data) {
            const fieldsrecords = data.fields;
            console.log('data Tyoe', fieldsrecords);
            console.log('datata',data.fields);
            const fieldsarray = [];
            for(var key in fieldsrecords) {           
                fieldsarray.push(
                    {
                        name: fieldsrecords[key].label,
                        FieldAPIName: fieldsrecords[key].apiName,
                        type: fieldsrecords[key].dataType
                       
                     }
                )           
            }
                                         
            this.datatable=fieldsarray;                
        }
    }

    @api handlechange1(){        
         this.datatable=[];
         //refreshApex(this.datatable);
    }
    
    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        this.commasepratedfields = '';
        const datararray = [];
        this.columnsrecords=[];
        console.log('checki', selectedRows);
        selectedRows.map(element=>{
                  console.log('Element', element);
                this.columnsrecords.push(
                    {
                        label: element.name,
                        fieldName: element.FieldAPIName,
                        type: element.type
                                                                                        
                    })
            
                if(this.selectedRows!=='' && this.commasepratedfields!=='') {
                    this.commasepratedfields += ','+element.FieldAPIName;
                }
                else {
                    this.commasepratedfields = element.FieldAPIName;
                }
        });
         
      console.log('Inside loop', this.columnsrecords);
                    
    }

    retrieveRecords(){
        retreieveRecords({objectName: this.selectedobjecttofetchfield, fieldAPINames: this.commasepratedfields})
        .then(result=>{              
                this.displaydata=result;
                for(var key in result) {
                    console.log('Result string:', result[key]);
                }  
                console.log('Result', this.displaydata);        
        }).catch(error => { 
              console.log('Error:', error.body.message);
        });
     }
}