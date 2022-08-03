@RestResource(urlMapping='/Account/*')
global class AccountManager {
   @HttpGet 
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String AccountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT Id,Name,(SELECT Id, Name From Contacts) FROM Account
                        WHERE Id = :AccountId];
        
        return result;
    }
}