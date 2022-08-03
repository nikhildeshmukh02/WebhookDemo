import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    strvalue = '';
    
    // To call the child component method to add the Contact into the list.
    addString(event){
        const objChild = this.template.querySelector('c-child-component');
        objChild.addStringToList(this.strvalue);
    }
    // To update the Contact name after updating it on UI. 
    changeName(event){
        this.strvalue = event.target.value;
    }
}