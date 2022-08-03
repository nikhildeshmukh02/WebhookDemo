public with sharing class dynamicLightningTable {
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts(){
        return [SELECT Id, FirstName,LastName, Phone, Email FROM Contact limit 15];
    }
}