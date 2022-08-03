public class ParkLocator {
    public static List<String> country(String countryName){
        if(countryName== null){
            countryName= 'India';
        }
        ParkService.ParksImplPort  parkSeviceByCountry = 
            new ParkService.ParksImplPort ();
      //  System.debug('Test Result: '+parkSeviceByCountry.byCountry('India'));
        return  parkSeviceByCountry.byCountry(countryName);
    }
}