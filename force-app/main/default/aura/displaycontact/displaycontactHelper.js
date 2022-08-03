({
	getContactOnLoad : function(component, event, helper) {
		var action= component.get('c.getContact');
        action.setCallback(this,function(response){component.set("v.ContactList",response.getReturnValue())});
       $A.enqueueAction(action);
	},
})