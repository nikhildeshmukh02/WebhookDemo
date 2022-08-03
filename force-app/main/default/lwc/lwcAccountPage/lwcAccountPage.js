import { LightningElement, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
export default class LwcAccountPage extends LightningElement {
    @track isModalOpen = true;
    accountObject = ACCOUNT_OBJECT;
    handleCancelClick() {
        this.isModalOpen = !this.isModalOpen;
    }
    handleSaveandNewClick() {
        this.isModalOpen = !this.isModalOpen;
    }

    handleSaveClick() {
        this.isModalOpen = !this.isModalOpen;
    }
}