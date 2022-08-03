public class displayContact_Controller {
@AuraEnabled
    public static LIST<Contact> getContact(){
        return [SELECT Id, FirstName, LastName, Email, Phone, Account.Name FROM Contact WHERE Account.Name!= null LIMIT 10];
    }
}