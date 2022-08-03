trigger opportunityLineItemTrigger on OpportunitylineItem (after Insert) {
    List<OpportunitylineItem> oppLineItemList = new  List<OpportunitylineItem>();
    set<Id> oppSet= new set<Id>();
    For(OpportunitylineItem opp: Trigger.New){
        oppSet.add(opp.OpportunityId);
    }
    oppLineItemList = [SELECT Id, OpportunityId, Product2Id,Product2.Family FROM OpportunitylineItem WHERE OpportunityId=:oppSet ];
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
    If(oppListToUpdate.size() > 0){
        UPDATE oppListToUpdate;
    }  
}