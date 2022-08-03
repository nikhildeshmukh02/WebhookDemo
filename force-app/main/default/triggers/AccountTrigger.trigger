trigger AccountTrigger on Account(after Update) {
   /* map<id,account> accold=trigger.oldmap;
    map<id,account> accnew=trigger.newmap;
    set<id> keys=accold.keySet();
    list<id> myid=new list<id>();
    for(ID K : keys){
        account oldvalues = accold.get(K);
        account newvalues = accnew.get(K);
        system.debug('oldvalues : '+oldvalues);
        system.debug('newvalues : '+newvalues);
        if(oldvalues.phone!=newvalues.phone){
            myid.add(K);
        }
         system.debug('myid : '+myid);
    }
    for(contact con : [select lastname, phone,AccountId from contact where accountid in : myid]){
        account a = accold.get(con.accountid);
        account b = accnew.get(con.accountid);
        con.otherphone = a.phone;
        con.homephone = b.phone;
         system.debug('con : '+con);
    }*/
   system.debug('New Lead : '+Trigger.newmap); 
    system.debug('New Lead : '+Trigger.oldMap); 
}