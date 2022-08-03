import { LightningElement ,track,wire, api} from 'lwc';
import getObjectListBasedOnPermission from '@salesforce/apex/LCC_createNewController.getObjectListBasedOnPermission';

export default class LWC_createNew extends LightningElement {
    @track openModal=false;
    @track selectedvalue;
    @track getObjectList; 
    @track error; 
    @track success;
    @wire(getObjectListBasedOnPermission) getObjectList =[];
   openModalAction(){
        // eslint-disable-next-line no-undef
      //  console.log('open modal', getObjectList);
        this.openModal= true;
    }
    closeModal(){
        this.openModal=false;
    }
    selectedObject(event){
        this.selectedvalue= event.detail.value;
        console.log('selectedvalue : '+ this.selectedvalue);
    }
    connectedCallback() {
        getObjectListBasedOnPermission()
            .then(result => {
                this.getObjectList = result;
                this.error = undefined;
                console.log('getObjectList '+ JSON.stringify(result));
            })
            .catch(error => {
                this.error = error;
                this.getObjectList = undefined;
            });
        }
        get getObjectLists() {
            return this.getObjectList;
        }
       
}