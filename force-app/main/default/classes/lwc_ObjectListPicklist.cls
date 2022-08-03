global class lwc_ObjectListPicklist extends VisualEditor.DynamicPickList{
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('red', 'RED');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        List<Schema.SObjectType> objList = Schema.getGlobalDescribe().Values();     
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        for(Schema.SObjectType obj : objList){
            String name = obj.getDescribe().getName();
            if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                !name.containsignorecase('share') && !name.containsignorecase('feed') && !name.containsignorecase('Apex')) || 
                 name.toLowerCase().right(3) ==  '__c'){      
                   VisualEditor.DataRow value = new VisualEditor.DataRow(obj.getDescribe().getLabel(),obj.getDescribe().getName());
                   myValues.addRow(value);
                   system.debug('value : '+value);
               }
         }
        return myValues;
    }
}