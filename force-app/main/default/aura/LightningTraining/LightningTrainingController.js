({
    myAction : function(component, event, helper) {
        
    },
    handleClick:function(component, event, helper) {
        var message =component.get('!v.message');
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": message
        });
        toastEvent.fire();
    },
})