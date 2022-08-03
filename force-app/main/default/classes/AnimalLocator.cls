public class AnimalLocator {
    public static String getAnimalNameById(Integer Num) {
        String abc;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+Num);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String res=response.getBody();
        if (response.getStatusCode() == 200) {
            system.debug('response : '+response);
            system.debug('response : '+response.getBody());
            System.debug('Received the following animals:');
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('animals:'+results);
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            System.debug('animals:'+animal);
          abc=(String)animal.get('name');
              System.debug('animals:'+abc);
        }
          return abc;
    }    
}