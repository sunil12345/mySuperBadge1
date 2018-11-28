trigger MaintenanceRequest on Case (before update, after update) {
    
    System.debug('Je passe dans mon trigger');
    
    Map<Id, case> applicableCases = new Map<Id, case>();
    
    if (Trigger.isUpdate) {
        if (Trigger.isAfter) {

             for(Case a : Trigger.new)
             {
                 if(a.IsClosed && (a.type == 'Repair' || a.type =='Routine Maintenance'))
                 {
                       applicableCases.put(a.id, a);
                         
                       System.debug('Case applicable :' + a.CaseNumber);
                 }
             }
        }
    }
            
    MaintenanceRequestHelper.updateWorkOrders(applicableCases);
    
}