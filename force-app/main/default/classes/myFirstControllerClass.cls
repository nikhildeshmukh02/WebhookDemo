public class myFirstControllerClass {
    @AuraEnabled
    public static Id saveContact(String name){
        contact con = new Contact();
        con.LastName=name;
        insert con;
        return con.Id;
    }
    
}