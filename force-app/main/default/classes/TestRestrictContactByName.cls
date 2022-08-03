@isTest
public class TestRestrictContactByName {
    @isTest public static void contactDeletion(){
        contact c=new contact();
        c.lastname='INVALIDNAME';
        insert c;
    }
}