import { LightningElement ,track} from 'lwc';

export default class HierarchyComponent extends LightningElement {
    @track
    tableData =[
                {
                    Name: "United States",
                    Id: 1,
                    iconName: "utility:chevronright",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Massachusetts",
                    Id: 2,
                    iconName: "utility:chevronright",
                    parentId: 1,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Boston",
                    Id: 3,
                    iconName: "",
                    parentId: 2,
                    rowStyle : "hide",
                    nameStyle : "margin-left:20px;"
                },              
                {
                    Name: "New York",
                    Id: 4,
                    iconName: "",
                    parentId : 1,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Vatican City",
                    Id : 5,
                    iconName: "",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Canada",
                    Id : 6,
                    iconName: "utility:chevronright",
                    parentId : null,
                    rowStyle : "",
                    nameStyle : ""
                },
                {
                    Name: "Ontario",
                    Id : 7,
                    iconName: "",
                    parentId : 6,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                },
                {
                    Name: "Alberta",
                    Id : 8,
                    iconName: "",
                    parentId : 6,
                    rowStyle : "hide",
                    nameStyle : "margin-left:10px;"
                }
            ];

    showOrHideChildrenRows(event){
        let rowId = event.target.dataset.rowid;
        let isExpanded = event.target.dataset.expanded;
        event.target.iconName = JSON.parse(isExpanded) ? "utility:chevronright": "utility:chevrondown";
        event.target.dataset.expanded = JSON.stringify(!JSON.parse(isExpanded));

        this.tableData = this.tableData.map((obj) => {
            if(obj.parentId == rowId &&  !JSON.parse(isExpanded)){
                obj.rowStyle = "";
            }
            if(obj.parentId == rowId && JSON.parse(isExpanded)){
                obj.rowStyle = "hide";
            }
            return obj;
        });
        console.log(this.tableData);

    }
}