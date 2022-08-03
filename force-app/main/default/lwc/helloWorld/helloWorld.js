import { LightningElement, track } from 'lwc';
export default class HelloWorld extends LightningElement {
    @track enterName = 'World';    //default value
    changeHandler(event) {
        this.enterName = event.target.value; // add enter value in variable 
    }
}