trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here

    if (trigger.isAfter && trigger.isUpdate) {
        BillingCalloutService.callBillingService(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

}