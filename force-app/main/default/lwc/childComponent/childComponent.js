import { LightningElement , track, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @track lstStrings = [];
    
    // This method will add new Contact into Contact list.
    @api
    addStringToList(strvalue){
        this.lstStrings.push(strvalue);
    }
}