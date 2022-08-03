({
    doInitHelper : function(component, event, helper) {
        var action = component.get("c.getDefaultFieldValue");
        action.setParams({ObjectName : component.get('v.ObjectName')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allValues = response.getReturnValue();
                //  console.log('allValues--->' + JSON.stringify(allValues));
                var objectValue = allValues.sObjectData;
                //console.log('objectValue--->' + objectValue);
                var fieldList = allValues.fieldList;
                //console.log('fieldList--->' + fieldList);
                helper.dynamicTable(component,fieldList,objectValue);
            }        	         
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
                component.set('v.isLoaded',!component.get('v.isLoaded'));
            }
        });
        $A.enqueueAction(action);
    },
    getFields_Helper : function(component, event, helper) {
        var action = component.get("c.getFiedlNames");
        action.setParams({ObjectName : component.get('v.ObjectName')});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {           
                var allValues = response.getReturnValue();
               // console.log('allValues: ',allValues);
                component.set('v.fieldsName', allValues);
                component.set('v.isLoaded',!component.get('v.isLoaded'));
            }        	         
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
                component.set('v.isLoaded',!component.get('v.isLoaded'));
            }
        });
        $A.enqueueAction(action);
    },
    
    getSelectedFieldData_Helper : function(component, event, helper) {
        var headerList =component.get('v.selectedValue');
        console.log('headerList; ',headerList);
        var action = component.get("c.objectRecords");
        action.setParams({selectedFields : component.get('v.selectedValue'),
                          ObjectName:component.get('v.ObjectName')
                         });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {  
                //component.find('sfdcDiv').set("v.body",[]);
                var allValues = response.getReturnValue();
                var objectValue = allValues.sObjectData;
                var fieldList = allValues.fieldList;
                helper.dynamicTable(component,fieldList,objectValue);
                
            }        	         
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                    errors[0].message);
                    }
                } 
                else {
                    console.log("Unknown Error");
                }
                component.set('v.isLoaded',!component.get('v.isLoaded'));
            }
        });
        $A.enqueueAction(action);
    },
    dynamicTable:function(component,fieldList,objectValue){
        var sObjectDataTableHeader = [];
        var sObjectData = [];
        for (var i=0; i<fieldList.length; i++) {
            sObjectDataTableHeader.push(fieldList[i].label);
        }	
        if(objectValue.length){
            for(var j=0; j<objectValue.length; j++){
                for (var i=0; i<fieldList.length; i++) {
                    sObjectData.push(objectValue[0][fieldList[i].apiName]);
                }
            }
        }
        console.log('fieldList :',fieldList);
        console.log('objectValue :',objectValue);
        var targetCmp=component.find("newDtPlaceholder");
        targetCmp.set("v.body",[]); //destroying existing one
        component.set('v.body', []);
        $A.createComponent(
            "lightning:datatable",
            {
                "data":objectValue,
                "columns":fieldList,
                "keyField":"Id",
                "hideCheckboxColumn":"true",
            },
            function(tbl,state,message)
            {
                    var body=targetCmp.get("v.body");
                    body.push(tbl);
                    targetCmp.set("v.body",body);
                    component.set('v.body', [tbl]);
             }
        );
        component.set('v.isLoaded',!component.get('v.isLoaded'));
        /*   var sObjectDataTableHeader = [];
        var sObjectData = [];
        for (var i=0; i<fieldList.length; i++) {
            sObjectDataTableHeader.push(fieldList[i].label);
        }	
        if(objectValue.length){
            for(var j=0; j<objectValue.length; j++){
                for (var i=0; i<fieldList.length; i++) {
                    sObjectData.push(objectValue[j][fieldList[i].apiName]);
                }
            }
        }
        console.log('sObjectDataTableHeader :',sObjectDataTableHeader);
        console.log('accountData :',sObjectData);
        component.set('v.headerList',sObjectDataTableHeader); 
        component.set('v.accountData',sObjectData); 
        
        component.set('v.isLoaded',!component.get('v.isLoaded'));
         var sObjectDataTableHeader = [];
        for (var i=0; i<fieldList.length; i++) {
            sObjectDataTableHeader.push(fieldList[i].label);
        }
        console.log('sObjectDataTableHeader--->>' + sObjectDataTableHeader);
        var columnCount = sObjectDataTableHeader.length;
        var table = document.createElement("TABLE");
        var row = table.insertRow(-1);
        for (var i=0; i<columnCount; i++) {
            var headerCell = document.createElement("TH");
            headerCell.innerHTML = sObjectDataTableHeader[i];
            headerCell.className='headerClass';
            row.appendChild(headerCell);
        }
        var dvTable = document.getElementById("sfdctable");
        dvTable.innerHTML = "";
        dvTable.appendChild(table);
        if(objectValue.length){
            for(var j=0; j<objectValue.length; j++){
                row = table.insertRow(-1);
                for (var i=0; i<fieldList.length; i++) {
                    var cell = row.insertCell(-1);
                    cell.innerHTML = objectValue[j][fieldList[i].apiName]; 
                }
            }
        }
        component.set('v.isLoaded',!component.get('v.isLoaded'));*/
    }, 
})