public with sharing class LCC_createNewController {
    public LCC_createNewController(){

}
@AuraEnabled(cacheable=true)
    Public static List<tabListWrapper> getObjectListBasedOnPermission(){
          UserAppInfo userAppInfo = [SELECT Id, AppDefinitionId FROM UserAppInfo WHERE UserId = :UserInfo.getUserId() LIMIT 1];
        AppDefinition appDefinition = [SELECT DurableId, Label FROM AppDefinition Where DurableId = :userAppInfo.AppDefinitionId LIMIT 1];
        // system.debug('current app label : '+appDefinition.Label);
        list<String> tabNames= new List<String>(); 
        list<tabListWrapper> tabDescription =new List<tabListWrapper>();
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        if(tabSetDesc!=null && tabSetDesc.size()>0)
            for(DescribeTabSetResult tsr : tabSetDesc) {
                system.debug('tsr: '+tsr);
                String appLabel = tsr.getLabel();
                tabNames.add(appLabel);
                if (appLabel == appDefinition.Label) {
                    List<Schema.DescribeTabResult> tabDesc = tsr.getTabs();
                    System.debug('-- Tab information for the Selected app --');
                    for(Schema.DescribeTabResult tr : tabDesc) {
                        String TabLabel = tr.getLabel();
                        System.debug('getLabel: ' + tr.getLabel());
                        if(TabLabel!=null && !string.isempty(TabLabel) && !TabLabel.containsignorecase('Home')
                            && !TabLabel.containsignorecase('Activities')  && !TabLabel.containsignorecase('Dashboards')
                            && !TabLabel.containsignorecase('Chatter')){
                                tabListWrapper tlw = new tabListWrapper();
                                tlw.label=TabLabel;
                                tlw.ObjectName=tr.getSobjectName();
                                tabDescription.add(tlw);
                            }
                    }
                }
            }
        return tabDescription;
    }
    @AuraEnabled
    Public static List<recordTypeWrapper> getRecordTypeList(String objectName){
        List<recordTypeWrapper> rtList =new List<recordTypeWrapper>();
        List<Schema.RecordTypeInfo> recordtypes = Schema.getGlobalDescribe().get(objectName).getDescribe().getRecordTypeInfos();    
        //recordtypemap = new Map<Id, String>();
        for(RecordTypeInfo rt : recordtypes){
            if(rt.getName() != 'Master' && rt.getName().trim() != '' && rt.isAvailable()){
                    recordTypeWrapper rtobj =new recordTypeWrapper();
            rtobj.Name =rt.getName();
            rtobj.recordTypeId =rt.getRecordTypeId();
            rtList.add(rtobj);
            }
                
            // recordtypemap.put(rt.getRecordTypeId(), rt.getName());
        }        
        return rtList;
    }
    
    public class tabListWrapper{
        @AuraEnabled
        public String label{get;set;}
        @AuraEnabled
        public String ObjectName{get;set;}
    }
    public class recordTypeWrapper{
        @AuraEnabled
        public String Name{get;set;}
        @AuraEnabled
        public String recordTypeId{get;set;}
    }
}