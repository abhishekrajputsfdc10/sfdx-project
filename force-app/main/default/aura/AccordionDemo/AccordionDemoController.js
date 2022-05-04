({
	doInit : function(component, event, helper) {
        var action = component.get('c.getContacts');
        action.setCallback(this, function(response){
            var state = response.getState();
            alert(state);
            if(state == 'SUCCESS'){
                component.set('v.conlist' , response.getReturnValue());
            } else{
                alert('Error');
            }
          
        });
       $A.enqueueAction(action);
		
	}
})