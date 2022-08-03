({
    getFinalProcessedRecord : function (component , records) {
        let counter = 0;
        let finalRecordData = [];
        for(let record of records) {
            for(let key of Object.keys(record)) {
                if(Object.keys(mapofAPI).includes(key) && record[key] === 'FAIL' && record[mapofAPI[key][2]] == false) {
                    let recordToPush = {};
                    recordToPush['apiName'] = mapofAPI[key][0];
                    
                    if(record[mapofAPI[key][1]]) {
                        recordToPush['errorCode'] = record[mapofAPI[key][1]];
                    }
                    if(record.Lead__c) {
                        recordToPush['leadId'] = record.Lead__c;
                    }
                    if(record.Lead__r && record.Lead__r.CRN__c) {
                        recordToPush['CRN'] = record.Lead__r.CRN__c;
                    }
                    if(record.Lead__r && record.Lead__r.Name) {
                        recordToPush['leadName'] = record.Lead__r.Name;
                    }
                    if(record.Lead__r && record.Lead__r.Scheme_Code__c) {
                        recordToPush['schemeCode'] = record.Lead__r.Scheme_Code__c;
                    }
                    if(record.Lead__r && record.Lead__r.FKYC_Submitted_Date__c) {
                        recordToPush['finalFKYCDate'] = record.Lead__r.FKYC_Submitted_Date__c;
                    }
                    recordToPush['phone'] = record.Lead__r && record.Lead__r.Phone ? record.Lead__r.Phone : '';
                    recordToPush['appId'] = record.Lead__r && record.Lead__r.AppRecId__c ? record.Lead__r.AppRecId__c : '';
                    recordToPush['Source'] = 'OTP';
                    recordToPush['rowId'] = ++counter;
                    recordToPush['recordId'] = record.Id;
                    finalRecordData.push(recordToPush);
                 }
            }
         } 
        component.set('v.allData', finalRecordData);
        component.set('v.filteredData', finalRecordData);
        this.preparePagination(component, finalRecordData); 
    },
    setColumns: function (component) {
        let textTypeColumns = ['Name','Type','Website','Active'];
        let finalColumns = [{label: 'Name', fieldName: 'Name', type: 'text', sortable: true,hideDefaultActions: true,cellAttributes:{ class: { fieldName: 'customCSSClass1' }}},
                            {label: 'Type', fieldName: 'Type', type: 'text', sortable: true,hideDefaultActions: true,cellAttributes:
                             { class: { fieldName: 'customCSSClass2' }}},
                            {label: 'Website', fieldName: 'Website', type: 'text', sortable: true,hideDefaultActions: true,cellAttributes:
                             { class: { fieldName: 'customCSSClass3' }}},
                            {label: 'Active', fieldName: 'Active__c', type: 'text',initialWidth: 300, sortable: true,hideDefaultActions: true,cellAttributes:
                             { class: { fieldName: 'customCSSClass4' }}},
                            ];
        
        //finalColumns;
        component.set('v.columns',finalColumns);
        component.set('v.textTypeColumns',textTypeColumns);
        
    },
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.allData");
        var reverse = sortDirection !== 'asc';
        console.log('the reverse is'+reverse);
        let stringField = cmp.get("v.textTypeColumns");
        
        if(!stringField.includes(fieldName)) {
            data = Object.assign([],
                                 data.sort(this.sortBy(fieldName, reverse ? 1 : -1))
                                );
        } else {
            console.log('not in prior');
            if(reverse) {
                console.log('desc');
                data = Object.assign([],
                                     data.sort(function(a,b){
                                         let x = a[fieldName] ? a[fieldName].toUpperCase() : '';
                                         let y = b[fieldName] ? b[fieldName].toUpperCase(): '';
                                         if (x < y) {return -1;}
                                         if (x > y) {return 1;}
                                         return 0;
                                     }));
            } else {
                console.log('asc');
                data = Object.assign([],
                                     data.sort(function(a,b){
                                         let x = a[fieldName] ? a[fieldName].toUpperCase() : '';
                                         let y = b[fieldName] ? b[fieldName].toUpperCase(): '';
                                         if (x > y) {return -1;}
                                         if (x < y) {return 1;}
                                         return 0;
                                     }));
            }
        }
        cmp.set('v.filteredData', data);
        this.preparePagination(cmp, data);
        //cmp.set("v.tableData", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer
        ? function(x) {
            return primer(x[field]);
        }
        : function(x) {
            return x[field];
        };
        
        return function (a, b) {
            var A = key(a)?key(a):'';
            var B = key(b)?key(b):'';
            return reverse * ((A > B) - (B > A));
        };
    },
    searchRecordsBySearchPhrase : function (component) {
        console.log()
        let searchPhrase = component.find('enter-search').get('v.value');
        let allData = JSON.parse(JSON.stringify(component.get("v.allData")));
        let noData = JSON.parse(JSON.stringify(component.get("v.allData")));
        if (!$A.util.isEmpty(searchPhrase)) {
            
            let filteredData = [];                                                        
            for(const data of allData) {
                let re = new RegExp(searchPhrase,'gi');
                let found = false;
                
                if(data.leadName && data.leadName.match(re) && data.leadName.match(re).length > 0) {
                    data.customCSSClass2 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                    
                }
                if(data.apiName && data.apiName.match(re) && data.apiName.match(re).length > 0) {
                    data.customCSSClass3 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                    
                }
                if(data.errorCode && data.errorCode.match(re) && data.errorCode.match(re).length > 0) {
                    data.customCSSClass4 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                    
                }
                if(data.schemeCode && data.schemeCode.match(re) && data.schemeCode.match(re).length > 0) {
                    data.customCSSClass5 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                }
                if(data.Source && data.Source.match(re) && data.Source.match(re).length > 0) {
                    data.customCSSClass7 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                }
                
                if(data.CRN && data.CRN.toString().match(re) && data.CRN.toString().match(re).length > 0) {
                    data.customCSSClass1 = 'row-color';
                    if(!found) {
                        found = true;
                        filteredData.push(data);
                    }
                }
                
            }
            // filteredData 
            
            component.set("v.filteredData", filteredData);
            this.preparePagination(component, filteredData);
        } else {
            
            component.set("v.filteredData", noData);
            this.preparePagination(component, noData);
        }
    },
    preparePagination: function (component, filterRecords) {
        let countTotalPage = Math.ceil(filterRecords.length/component.get("v.pageSize"));
        let totalPage = countTotalPage > 0 ? countTotalPage : 1;
        component.set("v.totalPages", totalPage);
        component.set("v.currentPageNumber", 1);
        this.setPageDataAsPerPagination(component);
    },
    setPageDataAsPerPagination: function(component) {
        let data = [];
        let pageNumber = component.get("v.currentPageNumber");
        let pageSize = component.get("v.pageSize");
        let filteredData = component.get('v.filteredData');
        
        let x = (pageNumber - 1) * pageSize;
        for (; x < (pageNumber) * pageSize; x++){
            if (filteredData[x]) {
                data.push(filteredData[x]);
            }
        }
        component.set("v.tableData", data);
    },
    showToast : function (component , message , varient) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: message+' Api request submitted',
            duration:' 3000',
            type: varient,
            mode: 'dismissible'
        });
        toastEvent.fire();
    }
})