({
    navigateTo: function(component, recId) {
        alert('in');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recId
        });
        navEvt.fire();
    }
})