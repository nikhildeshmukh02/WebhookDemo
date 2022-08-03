({
    init : function(component, event, helper) {
        var value = component.get('v.simpleRecord.checked__c');
        if(value == true){
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Saved",
                "message": "alredy true."
            });
            resultsToast.fire();
        }else{
            var auraIdValue = component.find("recordLoader");           
            component.set('v.simpleRecord.checked__c',true);
            console.log('checked :',component.get('v.simpleRecord.checked__c'));
            component.find("recordLoader").get("e.recordSave").fire();
            //auraIdValue.get("e.recordSave").fire();
            console.log('auraIdValue :',auraIdValue);
            //;
        }
        console.log('value :',value);        
    }
})