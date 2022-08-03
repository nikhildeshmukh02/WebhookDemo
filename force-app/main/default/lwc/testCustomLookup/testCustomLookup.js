import { LightningElement,api } from 'lwc';

export default class TestCustomLookup extends LightningElement {
    @api selectedRecord;
    @api sectionName;
    onRecordSelection(event){
        this.sectionName=event.detail.sectionName;
        this.selectedRecord=event.detail.selectedRecordList;
console.log('details :',event.detail.selectedRecordList);
console.log('details :',event.detail.sectionName);
    }
}