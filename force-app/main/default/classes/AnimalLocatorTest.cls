@isTest public class AnimalLocatorTest {
      
    @isTest static  void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        string result = AnimalLocator.getAnimalNameById(3);
        String expectedResult = 'trailhead';
        System.assertEquals(result,expectedResult );
              
    }   
}