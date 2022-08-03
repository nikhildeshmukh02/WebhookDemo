({
	myAction : function(component, event, helper) {
		 component.set('v.columns', [
            {label: 'Contact name', fieldName: 'ContactName', type: 'text'},
            {label: 'Account name', fieldName: 'accountName', type: 'text'},
        ]);
             helper.getAccountContactDataHelper(component,event,helper);
	}
})