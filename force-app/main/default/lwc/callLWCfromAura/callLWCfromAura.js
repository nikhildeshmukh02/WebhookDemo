import { LightningElement } from 'lwc';
export default class CallLWCfromAura extends LightningElement {
    Message='Hello, I am Lightning web component ';
    closeModal() {
        this.dispatchEvent( new CustomEvent('closeQuickAction'));
      }
}