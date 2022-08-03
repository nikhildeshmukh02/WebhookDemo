trigger opportunityTrigger on Opportunity (before insert) {
   List<OpportunitylineItem> oppLineItemList = new    List<OpportunitylineItem>();
    system.debug(' Trigger.New : '+ Trigger.New);
    oppLineItemList = [SELECT Id, OpportunityId, Product2Id,Product2.Family FROM OpportunitylineItem WHERE OpportunityId=: Trigger.New];
     system.debug(' oppLineItemList : '+ oppLineItemList);
    List<Opportunity> oppListToUpdate =new List<Opportunity> ();
    if(oppLineItemList.size() > 0){
        for(OpportunitylineItem olt:oppLineItemList){
            If(olt.Product2.Family =='Sponsor'){
                Opportunity op=new Opportunity();
                op.Id=olt.OpportunityId;
                op.Type='Sponsor';
                oppListToUpdate.add(op);
            }
        }
    }
      system.debug(' oppListToUpdate: '+ oppListToUpdate);
    If(oppListToUpdate.size() > 0){
        UPDATE oppListToUpdate;
    }
    
}