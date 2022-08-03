public with sharing class AccountUtils {
    public static List<Account> accountsByState(String abbreviation){
        List<Account> accountList =new List<Account>();
        accountList= [SELECT Id, Name, BillingState FROM Account WHERE BillingState =: abbreviation];
        return accountList;
    }
}