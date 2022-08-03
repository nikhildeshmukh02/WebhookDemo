public class MetadataExample {
    
    public void updateMetadata (){
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
        customMetaData.fullName = 'MyNamespace__MyMetadataTypeName.MyMetadataRecordName';
        
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = 'customField__c';
        customField.value = 'New value';
        
        customMetaData.values.add(customField);
        Metadata.DeployContainer deployContainer = new Metadata.DeployContainer();
        deployContainer.addMetadata(customMetaData);
        
        Id asyncResultId = Metadata.Operations.enqueueDeployment(deployContainer,null);
    }
}