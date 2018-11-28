trigger ChildAccount on Account (after insert, after update) {
   
   List<Account> AccountList= new List<Account>();
   
   Map<Id, Account> mapIdAccount =  new Map<Id, Account>();
   
   Map<Id, Integer> mapIdCount =  new Map<Id, Integer>();
   
   Integer intMonth =0;

    for(Account objAccount: Trigger.new){
        if (objAccount.Start_Date__c != null && objAccount.End_Date__c != null) {
         
          mapIdAccount.put(objAccount.Id, objAccount);        
        }
    }
    
    Date a = Date.newInstance(2013,10,7);
    Date b = Date.newInstance(2014,1,12);
    Integer monthDiff = 0;

    for(Account objAccountnew : mapIdAccount.values()){
        
        a = Date.newInstance(objAccountnew.Start_Date__c.year(), objAccountnew.Start_Date__c.month(), objAccountnew.Start_Date__c.day());
        
        b = Date.newInstance(objAccountnew.End_Date__c .year(), objAccountnew.End_Date__c .month(), objAccountnew.End_Date__c .day());
        
        monthDiff = a.monthsBetween(b);
        
        mapIdCount.put(objAccountnew.Id, monthDiff );
        
        system.debug('***mapIdCount.get(objAccountnew.Id)**'+mapIdCount.get(objAccountnew.Id));
        for(Integer index=0; index <= mapIdCount.get(objAccountnew.Id) ; index++){
        
        
            Account objectAcc= new Account(ParentId = objAccountnew.Id, Name= 'TestAcc'+index );
            AccountList.add(objectAcc);
        }
        
    }
    
   
  
   

    If(!AccountList.isEmpty()){
        
        insert AccountList;
    }
    
    system.debug('****AccountList***'+AccountList);
}