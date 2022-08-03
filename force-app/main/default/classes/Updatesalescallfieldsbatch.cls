global class Updatesalescallfieldsbatch implements Database.Batchable<SObject>{
    global  Iterable<Sobject> start(Database.BatchableContext BC){
        Iterable<SObject> myIter = (Iterable<SObject>) new CustomIterable();
        return myIter; 
    }
    global void execute(Database.BatchableContext BC, List<Sobject> scope){
        
        System.debug('list :'+scope);
        String SalescallID ='0012v';
        String EventId='0032v';
        Map<Id, sObject> salesCallMap = new Map<Id, sObject> (); 
        Map<Id, sObject> eventMap = new Map<Id, sObject> (); 
        
        for(sObject objectInstance :scope) { 
            string IDs = (String)objectInstance.get('ID'); 
            system.debug('IDs'+IDs);
            if(IDs.startswith(SalescallID)) { 
                salesCallMap.put(objectInstance.Id,objectInstance);
            } else if(IDs.startswith(EventId)) {
                eventMap.put(objectInstance.Id,objectInstance);
            } 
        }
        List<Account> salesCallList= new  List<Account>();
        for(sObject sales :salesCallMap.values()){
            for(sObject even :eventMap.values()){
                Account salecCallInstance= new Account();
                sObject  salesCall=eventMap.get(sales.Id);
                System.debug('salesCall :'+salesCall);
            }
            System.debug('accountList :'+salesCallMap);
            System.debug('contactList :'+eventMap);
            
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
}