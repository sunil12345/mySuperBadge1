Trigger HistoryTrack on CampaignMember (after insert, before update, before delete) {          
List<CampaignHistory__c> ch= new List<CampaignHistory__c>(); 
List<CampaignMember> cmOld= Trigger.old;  
List<String> changes  = new List<String>(); 
List<String> CampHisId  = new List<String>(); 
integer i=0;     
if(Trigger.isDelete){
            for(CampaignMember cm: Trigger.old ){     
                       String s;                            
                       s='Campaign Member id ' + cm.id + 
                       'is Deleted from campaign id: '+ cm.campaignId + 'by user '+ userinfo.getUserName();                                        
                       changes.add(s);
                       CampHisId.add(cm.campaignId);
                       CampaignHistory__c c= new CampaignHistory__c();               
                       c.Name='History'+DateTime.now();  
                       System.debug('CName:'+c.Name);
                       c.CampaignId__c=CampHisId[i];
                       System.debug('CampaignId:'+c.CampaignId__c);                              
                       c.HistoryDetails__c=changes[i];
                      System.debug('CHistory:'+c.HistoryDetails__c);         
                      ch.add(c);                              
                      i++;           
             } 
        }else {      
                     for(CampaignMember cm: Trigger.new ){  
                            String s;
                            if((Trigger.isUpdate)){
                                   if(cmOld[i].status!=cm.status){    
                                          s='on dated ' + DateTime.now() +                        
                                            ' status changed from ' + cmOld[i].status + ' to ' + cm.status +                        
                                            ' by user ' + userinfo.getUserName();
                                           
                                           changes.add(s);
                                          CampHisId.add(cm.campaignId);                                                  
                                          CampaignHistory__c c= new CampaignHistory__c();                          
                                          c.Name='History'+DateTime.now();
                                          System.debug('CName:'+c.Name);
                                          c.CampaignId__c=CampHisId[i];                        
                                          System.debug('CampaignId:'+c.CampaignId__c);                                      
                                          c.HistoryDetails__c=changes[i];
                                          System.debug('CHistory:'+c.HistoryDetails__c);
                                          ch.add(c); 
                                      }else if(cmOld[i].campaignId!=cm.campaignId){                        
                                                s='Changed Campaign id from : '+ cmOld[i].campaignId + 'to :' + cm.campaignId +                        
                                                    ' by user '+ userinfo.getUserName();  
                                              changes.add(s);                        
                                             CampHisId.add(cm.campaignId);                                                            
                                            CampaignHistory__c c= new CampaignHistory__c();                           
                                            c.Name='History'+DateTime.now();
                                            System.debug('CName:'+c.Name);              
                                            c.CampaignId__c=CampHisId[i];                   
                                           System.debug('CampaignId:'+c.CampaignId__c);                                          
                                            c.HistoryDetails__c=changes[i];
                                            System.debug('CHistory:'+c.HistoryDetails__c);                         
                                            ch.add(c);
                                         }             
                           }else if(Trigger.isInsert){                                
                                       s='A new Campaign Member id : ' + cm.id + ' is added to Campaign id :' + cm.campaignId +' by user '+ userinfo.getUserName();
                                       changes.add(s);                    
                                       CampHisId.add(cm.campaignId);                    
                                       System.debug('s>>>'+s);                                                                    
                                       CampaignHistory__c c= new CampaignHistory__c();
                                       c.Name='History'+DateTime.now();                   
                                       System.debug('CName:'+c.Name);
                                       c.CampaignId__c=CampHisId[i];
                                       System.debug('CampaignId:'+c.CampaignId__c);                                          
                                       c.HistoryDetails__c=changes[i];
                                       System.debug('CHistory:'+c.HistoryDetails__c);                                        
                                       ch.add(c);
                            } 
                            i++;     
                       }         
                }    
                insert ch;
     }