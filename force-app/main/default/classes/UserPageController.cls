public class UserPageController {
    public user usr{get;set;}
    public String selectedProfileString{get;set;}
    Set<String> originalvalues = new Set<String>{'A','B','C','D','E','F','G'};
        Public List<string> leftselected{get;set;}
    Public List<string> rightselected{get;set;}
    Set<string> leftvalues = new Set<string>();
    Set<string> rightvalues = new Set<string>();
    public UserPageController(){
        //selectedProfileString='FSE';
        leftselected = new List<String>();
        rightselected = new List<String>();
        leftvalues.addAll(originalValues);
        usr=new User();
    }
    public void onchangeMethod(){
        system.debug('onchangeMethod');
        usr.LastName=usr.FirstName;
    }
    public list<SelectOption> getradioButtonOptions(){
        list<SelectOption> options = new list<SelectOption>();
        options.add(new SelectOption('FSE', 'FSE'));
        options.add(new SelectOption('Coordination/Call Center', 'Back Office'));
        return options;
    }
    list<SelectOption> profileOptions = new list<SelectOption>();
    public list<SelectOption> getprofileList(){
        profileOptions.clear();
        if(selectedProfileString == null){
            selectedProfileString='FSE';
        }
        String searchString ='%'+selectedProfileString+'%';
        
        system.debug('searchString : '+searchString);
        profileOptions.add(new selectOption('--None--','--None--'));
        for(Profile objEmp:[SELECT Id,Name FROM Profile WHERE Name Like:searchString]){
            profileOptions.add(new selectOption(objEmp.Id,objEmp.Name));
        }
        return profileOptions;
    }
    //Others multiselect picklist
    
    public PageReference selectclick(){
        rightselected.clear();
        for(String s : leftselected){
            leftvalues.remove(s);
            rightvalues.add(s);
        }
        return null;
    }
    
    public PageReference unselectclick(){
        leftselected.clear();
        for(String s : rightselected){
            rightvalues.remove(s);
            leftvalues.add(s);
        }
        return null;
    }
    
    public List<SelectOption> getunSelectedValues(){
        List<SelectOption> options = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(leftvalues);
        tempList.sort();
        for(string s : tempList)
            options.add(new SelectOption(s,s));
        return options;
    }
    
    public List<SelectOption> getSelectedValues(){
        List<SelectOption> options1 = new List<SelectOption>();
        List<string> tempList = new List<String>();
        tempList.addAll(rightvalues);
        tempList.sort();
        for(String s : tempList)
            options1.add(new SelectOption(s,s));
        return options1;
    }
    public PageReference save(){
        system.debug('save : ');
        return null;
    }
}