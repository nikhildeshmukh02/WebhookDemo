@RestResource(urlMapping='/api/Webhooks/pushDetailsdemo/*')
global with sharing class weBhookDemo {
    @HttpPost
    global static void handleNotification() {
try{
    RestRequest request=RestContext.request;
    RestResponse response= RestContext.response;
system.debug('request : '+request);
system.debug('response : '+response);
}catch(Exception e){
system.debug('Exc: '+e);
}
    } 
}
