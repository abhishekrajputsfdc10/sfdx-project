({
	doinit : function(component, event, helper) {
        helper.fetchPickListVal(component, 'Industry', 'accIndustry');
	
	},
	
	onPicklistChange : function(component, event, helper){
	    alert(event.getSource().get("v.value"));
	},
})