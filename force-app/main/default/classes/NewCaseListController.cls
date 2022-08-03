public class NewCaseListController {
    Public List<Case> getNewCases(){
        List<Case> caseList=[Select Id,CaseNumber, Status  From Case Where Status='New'];
        return caseList;
    }
}