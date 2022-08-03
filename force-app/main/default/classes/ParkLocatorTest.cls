@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
      
        String country = 'India';
        String country2 = null;
        List<String> result = ParkLocator.country(country);
         List<String> result1 = ParkLocator.country(country2);
        // Verify that a fake result is returned
        //System.assertEquals(3.0, result); 
    }
}