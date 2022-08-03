@isTest
public class AccountManagerTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Account acc= new Account();
        acc.Name ='test';
        insert acc;
        contact cnc= new contact();
        cnc.lastName=' Test ';
        cnc.AccountId=acc.Id;
        insert cnc;
        //Test.setMock(AccountManagerMock.class, acc);
        Test.setMock(HttpCalloutMock.class, new AccountManagerMock());
        // Call the method that invokes a callout
        AccountManager.getAccount();
    }
}