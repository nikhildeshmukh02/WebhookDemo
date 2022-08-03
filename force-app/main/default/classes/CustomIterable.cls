global class CustomIterable implements Iterable<SObject>, Iterator<SObject>{ 
    public Iterator<SObject> iterator() { return this; }
   List<SObject> sobjs {get; set;} 
   Integer i {get; set;} 
   public CustomIterable(){ 
       sobjs = new List<SObject>();
       
       List<Account> accs = [SELECT id, name, numberofEmployees FROM Account WHERE name !=: NULL ]; 
       for( Account acc : accs ) {
           sobjs.add(acc);
       }
       
       List<Contact> cons = [SELECT id,AccountId, name FROM Contact WHERE lastname !=: Null ]; 
       for( Contact con : cons ) {
           sobjs.add(con);
       }
       i = 0; 
       system.debug('sobjs : '+sobjs);
   }   
   global boolean hasNext(){ 
       if(i >= sobjs.size()) 
           return false; 
       else 
           return true; 
   }    
   global SObject next(){ 
       if(i == 8){ i++; return null;} 
       i=i+1; 
       return sobjs[i-1]; 
   } 
}