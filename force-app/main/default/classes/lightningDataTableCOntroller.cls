public class lightningDataTableCOntroller {
@AuraEnabled 
    public static List<Account> getAllRecord() {
        List<Account> listOfAccounts = [Select Id,Name,Type,Website,Active__c FROM Account];
         System.debug('list'+listOfAccounts);
        return listOfAccounts;
    }
}