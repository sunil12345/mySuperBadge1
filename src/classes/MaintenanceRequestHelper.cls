public class MaintenanceRequestHelper {
    
     public static void updateWorkOrders(Map<Id, case> applicableCases){
        
         list<sObject> allObjects = new list<sObject>();
         
         // Get the maintenance_cycle of the product for each product
         list<Product2> listProduct = [select Id, Maintenance_Cycle__c from Product2];  
         Map<Id,decimal> mapProduct = new Map<Id, decimal>();
         for (Product2 p : listProduct) {
             if (p != null) {
                 mapProduct.put(p.Id, p.Maintenance_Cycle__c);
             }
         }
         
         // For each case, create a new 'Routine Maintenance' case
         for (Case o : applicableCases.values()) 
         {
             Case a = new Case();
             
             a.RecordTypeId = '0126F000001C750'; // Id of a Routine Maintenance record type
             a.Subject = 'Routine Maintenance';
             a.Date_Reported__c = Date.today();
             a.Date_Due__c = Date.today();
             // Add the number of days of the Maintenance_Cyle
             if (mapProduct.get(o.Equipment__c) != null) {
                a.Date_Due__c += Integer.valueOf(mapProduct.get(o.Equipment__c));
             }
             a.Vehicle__c = o.Vehicle__c;
             a.Product__c = o.Product__c;
             a.ContactId = o.ContactId;
             a.AccountId = o.AccountId;
             a.AssetId = o.AssetId;
             
             if (o.recordTypeId=='0126F000001C750') {
                 a.Origin = 'Repair';
             } else {
                 a.Origin = 'Routine Maintenance';
             }
             a.Type = 'Routine Maintenance';
             
             allObjects.add(a);
             
          }//end for o
    
          try {
            insert allObjects;
          } catch (system.Dmlexception e) {
            system.debug (e);
          } 
    }        
    
}