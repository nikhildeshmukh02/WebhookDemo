import { LightningElement, track } from 'lwc';

export default class ModalBox extends LightningElement {
    @track openModal=false;
    openModalAction(){
        this.openModal= true;
    }
    closeModal(){
        this.openModal=false;
    }
}