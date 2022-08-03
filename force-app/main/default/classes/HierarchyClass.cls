public class HierarchyClass {
    /* This class is created for Lightning web component "lwcAccountHierarchy".
* This class is used to get GPO and IDN account Hierarchy.
*created date: 31 March 2021       
*created By: Nikhil Deshmukh
*/
    public static  List<item> items {get;set;}
    public static  Account IdnAccount {get;set;}
    public static  Account GpoAccount {get;set;}
    public static Boolean isGPO {get;set;}
    public static  Boolean isIDN {get;set;}  
    /*@AuraEnabled
    public static List<Item> getAccountHierarchy(Id recordId){
        try{
            isGPO=false;
            isIDN=false;
            Account acctList = new Account();
            LIST<Account> accountIdnList = new LIST<Account>();
            Account acctIdnGPOList = new Account();
            if(recordId != null){
                acctList = [SELECT Id, Name, RTG_GPO__c,RTG_GPO__r.Name,RTG_IDN__c,RTG_IDN__r.Name  From Account WhERE Id =:recordId LIMIT 1];    
            }
            if(acctList.RTG_GPO__c == null)
                acctIdnGPOList = [SELECT Id, Name, RTG_GPO__c,RTG_GPO__r.Name,RTG_IDN__c,RTG_IDN__r.Name  From Account WhERE RTG_GPO__c =:recordId AND RTG_IDN__c = null LIMIT 1];  
            if(acctList.RTG_GPO__c != null && acctList.RTG_IDN__c != null){
                // Facility Accounts
                accountIdnList=[SELECT Id, Name,RTG_IDN__c FROM Account  WHERE RTG_IDN__c =: acctList.RTG_IDN__c];
                createHierarchyData(acctList,accountIdnList,recordId);
            }else if(acctIdnGPOList.RTG_GPO__c !=  null){
                // GPO Accounts
                IdnAccount = new Account();
                IdnAccount.Id =acctIdnGPOList.Id;
                IdnAccount.Name=acctIdnGPOList.Name;
                accountIdnList=[SELECT Id, Name,RTG_IDN__c FROM Account  WHERE RTG_IDN__c =: acctIdnGPOList.Id];
                if(acctIdnGPOList.RTG_GPO__c == recordId)
                    isGPO=true;
                createHierarchyData(acctIdnGPOList,accountIdnList,recordId);
            }else if(acctList.RTG_GPO__c !=  null && acctList.RTG_IDN__c == null){
                //Idn accounts
                IdnAccount = new Account();
                IdnAccount.Id =acctList.Id;
                IdnAccount.Name=acctList.Name;
                accountIdnList=[SELECT Id, Name,RTG_IDN__c FROM Account  WHERE RTG_IDN__c =: acctList.Id];
                if(acctList.Id ==recordId)
                    isIDN=true;
                createHierarchyData(acctList,accountIdnList,recordId);
            }
            return items;
        }catch(exception e){
            system.debug('Ex: '+e.getLineNumber()+'ex : '+e.getMessage());
            return null;
        }
    }
    @AuraEnabled
    public static List<item> createHierarchyData(Account acctList, LIST<Account> accountIdnList ,Id recordId){
        List<GPOandIdnWrap> accountList = new List<GPOandIdnWrap>();
        GpoAccount = new Account();
        GpoAccount.Id =acctList.RTG_GPO__c;
        GpoAccount.Name=acctList.RTG_GPO__r.Name;
        if(acctList.RTG_IDN__c != null){
            IdnAccount = new Account();
            IdnAccount.Id =acctList.RTG_IDN__c;
            IdnAccount.Name=acctList.RTG_IDN__r.Name;
        }List<Account> RelatedAccount= new List<Account>();
        for(Account ac:accountIdnList){
            Account facilityAccount = new Account();
            facilityAccount.Id = ac.Id;
            facilityAccount.Name = ac.Name;
            RelatedAccount.add(facilityAccount); 
        }
        GPOandIdnWrap accList= new GPOandIdnWrap(GpoAccount,IdnAccount,RelatedAccount);
        accountList.add(accList);
        Boolean isSelected=false;
        items = new List<item>();
        for(GPOandIdnWrap gpo:accountList){
            List<item> accIDNList = new List<item>();
            List<item> facilityItemList = new List<item>();
            for(Account facility:gpo.RelatedAccount){
                if(facility.Id == recordId){
                    isSelected=true;
                }else{
                    isSelected=false;
                }
                item facilityItem = new item(facility.Name, String.valueOf(facility.Id), false, null,isSelected);
                facilityItemList.add(facilityItem);
            }
            item accIDN = new item(gpo.IdnAccount.Name, String.valueOf(gpo.IdnAccount.Id), false, facilityItemList,isIDN);
            accIDNList.add(accIDN);
            item accGPO = new item(gpo.GpoAccount.Name, String.valueOf(gpo.GpoAccount.Id), false, accIDNList,isGPO);
            items.add(accGPO);
        }
        return items;
    }*/
    @AuraEnabled  
    public static List<item> getHierarchy(Id recordId, String ChildObjectApiName, String ObjectAPIName, String relatedField){
        try{
            String childquery;
            String parentquery;
            List<sObject > childdDtaList = new List<sObject >();
            List<sObject > parentDataList = new List<sObject >();
            if(recordId != null){
                childquery='SELECT Id, Name FROM '+ChildObjectApiName +' WHERE  '+relatedField+' =:recordId';
                parentquery='SELECT Id, Name  FROM '+ObjectAPIName +' WHERE  Id =:recordId LIMIT 1';
            }
            if(recordId != null){
                childdDtaList = database.query(childquery);
                parentDataList = database.query(parentquery);
            }
            Boolean isSelected=false;
            List<item> childListItem = new List<item>();
            List<item> parentListItem = new List<item>();
            for(sObject parent:parentDataList){
                for(sObject child:childdDtaList){
                    item subItem = new item((String)child.get('Name'), String.valueOf(child.Id), false, null,false);
                    childListItem.add(subItem);
                }
                item mainItem = new item((String)parent.get('Name'), String.valueOf(parent.Id), false, childListItem,isSelected);
                parentListItem.add(mainItem);
            }
            return parentListItem;
        }catch(exception e){
            system.debug('Ex: '+e.getLineNumber()+'ex : '+e.getMessage());
            return null;
        }
    }
    //Item Wrapper Class
    public class item{
        @AuraEnabled
        public String label {get; set;}
        @AuraEnabled
        public String name {get; set;}
        @AuraEnabled
        public Boolean expanded {get; set;}
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public List<item> items {get; set;}
        public item(String label, String name, Boolean expanded, List<item> items, Boolean isSelected){
            this.label = label;
            this.name = name;
            this.expanded = expanded;
            this.items = items;
            this.isSelected =isSelected;
        }
    }
    //GPO and IDN Wrapper class
    public class GPOandIdnWrap{
        @AuraEnabled
        public Account GpoAccount{get; set;}
        @AuraEnabled
        public Account IdnAccount  {get; set;}
        @AuraEnabled
        public List<Account> RelatedAccount {get; set;}
        public GPOandIdnWrap(Account  GpoAccount, Account IdnAccount, List<Account>  RelatedAccount){
            this.GpoAccount = GpoAccount;
            this.IdnAccount = IdnAccount;
            this.RelatedAccount = RelatedAccount;
        }
    }
}