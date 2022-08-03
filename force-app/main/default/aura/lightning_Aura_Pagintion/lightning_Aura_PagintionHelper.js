({
    getContact_helper: function (component, helper) {
        var action = component.get("c.getContactData");
        var PaginationList = [];
        var pageSize = component.get("v.pageSize");
        var i=0;
        var  util =$A.util;
        action.setCallback(this, function (response) {
            var resultData = response.getReturnValue();
             if (resultData.length >0) {
                component.set('v.contactList', response.getReturnValue());
                component.set("v.totalRecords", component.get("v.contactList").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                for(i=0; i< pageSize; i++){
                    if(component.get("v.contactList").length> i)
                        PaginationList.push(response.getReturnValue()[i]);    
                }
                component.set('v.PaginationList', PaginationList);
                component.set('v.isSending',false);
                component.set('v.isLoaded', false);
            }else{
                component.set('v.PaginationList', null);
            }
            
        });
        $A.enqueueAction(action);
    },
})