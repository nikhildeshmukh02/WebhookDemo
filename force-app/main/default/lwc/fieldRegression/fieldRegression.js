import { LightningElement } from 'lwc';

export default class FieldRegression extends LightningElement {
    handleValidate(){
        const panCardRegex="[A-Z]{5}[0-9]{4}[A-Z]{1}";
        let panCard=this.template.querySelector(".panCard");
        let panCardVal=panCard.value;
        if(panCardVal.match(panCardRegex)){
            panCard.setCustomValidity("");

        }else{
            panCard.setCustomValidity("Please Enter the valid PanCard Number");
        }
        panCard.reportValidity();
    }
}