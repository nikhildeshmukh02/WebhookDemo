global without sharing  class accountListController {
    global List<Account> accounts;
    global List<Account> getAccounts() {
        if(accounts == null)
            accounts = [SELECT name,Phone,AccountNumber, owner.name,Parent.name FROM account WHERE AccountNumber !=null LIMIT 10];
        system.debug('accounts : '+accounts);
        return accounts;
    }
}