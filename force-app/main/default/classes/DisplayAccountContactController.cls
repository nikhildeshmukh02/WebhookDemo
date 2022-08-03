public class DisplayAccountContactController {
    
    @AuraEnabled
    Public static List<AccountContactWrapper>  getAccountContact(){
        List<Account> accList= new List<Account>([SELECT Id ,Name FROM Account LIMIT 10]);
        List<Contact> conList= new List<Contact>([SELECT Id ,Name FROM Contact LIMIT 10]);
        List<AccountContactWrapper> accWrapper=new List<AccountContactWrapper>();
        for(Account ac:accList){
            AccountContactWrapper accWrap=new AccountContactWrapper();
            accWrap.accountName=ac.Name;
            accWrapper.add(accWrap);
        }
        for(Contact con:conList){
            AccountContactWrapper conWrap=new AccountContactWrapper();
            conWrap.ContactName=con.Name;
            accWrapper.add(conWrap);
        }
        return accWrapper;
    }
    
    Public class AccountContactWrapper{
        @AuraEnabled
        Public  String accountName;
        @AuraEnabled
        Public  String ContactName;
    }
}