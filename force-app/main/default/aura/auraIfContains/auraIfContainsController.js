({
    doInit: function(component, event, helper) {
        var getList = component.get('v.list'); 
        var getElement = component.get('v.element');
        var getElementIndex = getList.indexOf(component.get('v.element'));
        
        if(getElementIndex != -1){ 
            component.set('v.condition',true);
        }else{
            component.set('v.condition',false);
        }
    },
})