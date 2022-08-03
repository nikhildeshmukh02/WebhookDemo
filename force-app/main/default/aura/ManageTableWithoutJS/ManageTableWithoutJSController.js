({
    doInit : function(component, event, helper) {
        component.set('v.isLoaded',!component.get('v.isLoaded'));
        helper.doInitHelper(component, event, helper);
    },
    openModel: function(component, event, helper) {
          
        component.set('v.isLoaded',!component.get('v.isLoaded'));
        component.set('v.isOpen',!component.get('v.isOpen'));
      component.set("v.selectedValue", []);
     
        helper.getFields_Helper(component, event, helper);
    },
    getSelectedFieldData : function(component, event, helper) {
          component.set('v.isLoaded',!component.get('v.isLoaded'));
        component.set('v.isOpen',!component.get('v.isOpen'));
        helper.getSelectedFieldData_Helper(component, event, helper);        
    },
    onSelectAllChange:function(component, event, helper) {
      
        var ischeked =event.getSource().get("v.checked");
        var ValueToadd =event.getSource().get("v.value");
        var selectedValue =component.get('v.selectedValue');
        if(ischeked){
            selectedValue.push(ValueToadd);
        }else{
            selectedValue.pop(ValueToadd);
        }
        component.set("v.selectedValue", selectedValue);
        console.log('selectedValue :',selectedValue);
    }
})