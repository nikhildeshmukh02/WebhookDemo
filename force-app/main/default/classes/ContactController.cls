public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        try {
            List<Contact> retriveContact=new List<Contact>();
            retriveContact=[SELECT Id, FirstName,LastName,Email FROM Contact  WITH SECURITY_ENFORCED];
            return retriveContact;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}
