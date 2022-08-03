({
    doInit:function (component, event, helper) {
        component.set('v.pageNumber',1);
        component.set('v.pageSize',10);
        component.set('v.isLoaded',true);
        helper.getContact_helper(component, helper);
    }, 
    handleNext : function(component, event, helper) { 
        var sObjectList = component.get("v.contactList");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var pageNumber;
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(sObjectList.length > i){
                Paginationlist.push(sObjectList[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
        pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
    },
    
    handlePrev : function(component, event, helper) {        
        var sObjectList = component.get("v.contactList");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        var pageNumber;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(sObjectList[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
        pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
    },
    
})