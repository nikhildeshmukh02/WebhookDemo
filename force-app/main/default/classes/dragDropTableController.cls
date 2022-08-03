public with sharing class dragDropTableController {
   @AuraEnabled
    public static List<Contact> getContactList() {
        return [SELECT Id, Name FROM Contact LIMIT 10];

    }
}