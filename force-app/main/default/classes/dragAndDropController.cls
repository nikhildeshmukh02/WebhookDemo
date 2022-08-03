public with sharing class dragAndDropController {
    @AuraEnabled
    public static ContentVersion getProfilePicture(Id parentId) {
        // Attachment permissions are set in parent object (Contact)
        try{
            return [SELECT Id, Title, LastModifiedDate FROM ContentVersion 
                    WHERE FirstPublishLocationId=:ParentId 
                    ORDER BY LastModifiedDate DESC LIMIT 1];
        }catch(Exception e){
            return null;
        }
    }
    
    @AuraEnabled
    public static Id saveAttachment(Id parentId, String fileName, String base64Data) { 
        try{
            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = '/' + fileName;
            cv.FirstPublishLocationId = parentId;
            cv.VersionData = EncodingUtil.base64Decode(base64Data);
            insert(cv) ;
            return cv.Id;
         }catch(Exception e){
            return null;
        }
    }
}