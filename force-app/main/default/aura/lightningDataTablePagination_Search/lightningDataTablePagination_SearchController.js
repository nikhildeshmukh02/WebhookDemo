({
    doInit : function(component, event, helper) {
        component.set('v.isLoading', true);
        helper.setColumns(component);       
        var action = component.get("c.getAllRecord");
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log(state);
            if (state === "SUCCESS") {
                var data = response.getReturnValue();
                 component.set('v.tableData',data);
                helper.preparePagination(component, data)
                console.log(data)
                if(data.length > 0) {
                    //  helper.getFinalProcessedRecord(component, data);
                }
                component.set('v.isLoading', false);
            } 
            if(state === "ERROR") {
                let errors = response.getError();
                console.log(errors);
                let message = 'Unknown error'; // Default error message
                // Retrieve the error message sent by the server
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                // Display the message
                console.error(message);
            }
        });
        $A.enqueueAction(action);
        
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        let leadId = row.leadId;
        let apiName = row.apiName;
        let crnNo = row.CRN;
        let recordId = row.recordId;
        let phone = row.phone;
        let appId = row.appId;
        
        switch (action.name) {
            case 'modify':
                
                let nav = cmp.find("navId");
                
                if(leadId) {
                    nav.navigate({
                        type: 'standard__app',
                        attributes: {
                            appTarget : 'c__DVU_Portal',
                            pageRef: {
                                type: "standard__recordPage",
                                attributes: {
                                    recordId: leadId,
                                    objectApiName: "Lead",
                                    actionName: "view"
                                }
                            }
                        }}); 
                } else
                {
                    nav.navigate({
                        type: 'standard__app',
                        attributes: {
                            appTarget : 'c__DVU_Portal'
                        }});
                }
                break;
                
            case 'retry':
                cmp.set('v.isLoading', true);
                var action = cmp.get("c.makeApiCall");
                action.setParams({apiName:apiName,leadId:leadId,crnNo:crnNo , phone : phone ? phone : '',recordId:recordId,
                                  appRecordId: appId ? appId : ''});
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        helper.showToast(cmp,apiName,'success');
                        let nestdata = response.getReturnValue();
                        console.log('nestData'+nestdata);
                        cmp.set("v.apiResponse",nestdata);
                        var action1 = cmp.get("c.getAllErrorRecord");
                        action1.setCallback(this, function(response){
                            var state = response.getState();
                            if (state === "SUCCESS") {
                                var data = response.getReturnValue();
                                if(data.length > 0) {
                                    helper.getFinalProcessedRecord(cmp, data);
                                }
                                cmp.set('v.isLoading', false);
                            }
                        });
                        $A.enqueueAction(action1);
                        cmp.set('v.isLoading', false);
                    }
                });
                $A.enqueueAction(action);
        }
    },
    updateColumnSorting: function (cmp, event, helper) {
        cmp.set('v.isLoading', true);
        // We use the setTimeout method here to simulate the async
        // process of the sorting data, so that user will see the
        // spinner loading when the data is being sorted.
        setTimeout($A.getCallback(function() {
            var fieldName = event.getParam('fieldName');
            var sortDirection = event.getParam('sortDirection');
            
            cmp.set("v.sortedBy", fieldName);
            helper.sortData(cmp, fieldName, sortDirection);
            
            cmp.set("v.defaultSortDirection", sortDirection === 'asc' ? 'desc' : 'asc');
            
            cmp.set('v.isLoading', false);
        }), 0);
    }	,
    onPageSizeChange: function(component, event, helper) {        
        helper.preparePagination(component, component.get('v.filteredData'));
    },
    onNext: function(component, event, helper) {        
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber + 1);
        helper.setPageDataAsPerPagination(component);
    },
    onPrev: function(component, event, helper) {        
        let pageNumber = component.get("v.currentPageNumber");
        component.set("v.currentPageNumber", pageNumber - 1);
        helper.setPageDataAsPerPagination(component);
    },
    onFirst: function(component, event, helper) {        
        component.set("v.currentPageNumber", 1);
        helper.setPageDataAsPerPagination(component);
    },
    onLast: function(component, event, helper) {        
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.setPageDataAsPerPagination(component);
    },
    handleSearch : function (component, event, helper) {
        helper.searchRecordsBySearchPhrase(component);
    }
})