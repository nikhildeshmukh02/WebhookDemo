public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer no, String lastName){
        system.debug('no : '+no);
        List<Contact> conList = new List<Contact>();
        contact con =new contact();
        for(Integer I=0 ;I <no; I++){
            conList.add(new Contact(firstName = 'firstName' +' '+I, lastName= lastName));
        }
        system.debug('conList : '+conList);
        return conList;
    }
}