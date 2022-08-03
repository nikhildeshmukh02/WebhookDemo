public class manageColumns_Apex {
    
    @AuraEnabled
    public static DynamicBindingWrapper getDefaultFieldValue(String ObjectName){
        DynamicBindingWrapper dynamicData = new DynamicBindingWrapper();
        List<fieldDataWrapper> wrapperList =  new List<fieldDataWrapper>();
        fieldDataWrapper wrapper = new fieldDataWrapper();
        wrapper.label = ObjectName + ' Name';
        wrapper.apiName = 'Name';
        wrapperList.add(wrapper);
        String sql = ' SELECT Name FROM ' + ObjectName +' LIMIT 10000' ;
        List<Sobject> objRecords = new List<Sobject>();
        objRecords = Database.Query(sql);
        if(objRecords!=null && objRecords.size()>0){
            dynamicData.sObjectData = objRecords;
        }
        else{
            dynamicData.sObjectData = new List<sObject>();
        }
        dynamicData.fieldList = wrapperList;
        return dynamicData;
   }
    @AuraEnabled
    public static List<fieldDataWrapper> getFiedlNames(String ObjectName){
        DynamicBindingWrapper dynamicData = new DynamicBindingWrapper();
        List<fieldDataWrapper> wrapperList =  new List<fieldDataWrapper>();
        List<String> fields = new List<String>();
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(ObjectName); 
        Schema.DescribeSObjectResult r1 = objType.getDescribe(); 
        Map<String , Schema.SObjectField> mapFieldList = r1.fields.getMap();  
        for(Schema.SObjectField field : mapFieldList.values())  {  
            Schema.DescribeFieldResult fieldResult = field.getDescribe();  
            if(fieldResult.isAccessible())  {  
                fields.add(fieldResult.getName());
            }
            fieldDataWrapper wrapper = new fieldDataWrapper();
            wrapper.label = field.getDescribe().getLabel();
            wrapper.apiName = field.getDescribe().getName();
            wrapperList.add(wrapper);
        }
        return wrapperList;
    }
    @AuraEnabled
    public static DynamicBindingWrapper objectRecords(List<String> selectedFields, String ObjectName){
        DynamicBindingWrapper dynamicData = new DynamicBindingWrapper();
        List<fieldDataWrapper> wrapperList =  new List<fieldDataWrapper>();
        List<String> fields = new List<String>();
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(ObjectName); 
        Schema.DescribeSObjectResult r1 = objType.getDescribe(); 
        Map<String , Schema.SObjectField> mapFieldList = r1.fields.getMap();
        Map<String , Schema.SObjectField> mapList = new Map<String , Schema.SObjectField>();
        for(String sc : selectedFields){
            if(mapFieldList.containsKey(sc)){
                mapList.put(sc,mapFieldList.get(sc));    
            }
        }
        for(Schema.SObjectField field : mapList.values())  {  
            Schema.DescribeFieldResult fieldResult = field.getDescribe();  
            if(fieldResult.isAccessible())  {  
                fields.add(fieldResult.getName());
            }
            fieldDataWrapper wrapper = new fieldDataWrapper();
            wrapper.label = field.getDescribe().getLabel();
            wrapper.apiName = field.getDescribe().getName();
            wrapperList.add(wrapper);
        }
        Integer i = 0;
        String fieldsToFetch = '';
        for(String temp:selectedFields){       
            Integer len = selectedFields.size();
            if(i==len-1){
                fieldsToFetch = fieldsToFetch + temp;
            }
            else{
                fieldsToFetch = fieldsToFetch + temp + ',';
            }
            i++;
        }
        String sql = ' SELECT ' + fieldsToFetch + ' FROM ' + ObjectName + ' LIMIT 10000';
        List<Sobject> objRecords = new List<Sobject>();
        objRecords = Database.Query(sql);
        if(objRecords!=null && objRecords.size()>0){
            dynamicData.sObjectData = objRecords;
        }
        else{
            dynamicData.sObjectData = new List<sObject>();
        }
        dynamicData.fieldList = wrapperList;
        return dynamicData;
    } 
    //Class to store the dynamic data and list of related fields
    public class DynamicBindingWrapper{
        @AuraEnabled
        public List<sObject> sObjectData {get; set;}
        @AuraEnabled
        public List<fieldDataWrapper> fieldList {get; set;}
    }
    //Class to store the field information
    public class fieldDataWrapper{
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String apiName {get; set;}
    }
}