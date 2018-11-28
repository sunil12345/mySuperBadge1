public class CustomLookupWindowController {

    public String searchString{get;set;}
    public List<Account> Hotels{get;set;}
    public Account newHotel{get;set;}
    public String renderFlag{get;set;}
    public String lookupId{get;set;}

    public CustomLookupWindowController(ApexPages.StandardController stdController){
        Hotels = new List<Account>();
        searchString = '';
        newHotel = new Account();
        GoForSearch();
    }

    public void GoForSearch(){
        Hotels = [Select id,Name from Account where name Like : '%'+searchString+'%'];
    }

    public void newHotel(){
        try{
            INSERT newHotel;
        }catch(Exception ex){
            System.debug('Exception == '+ex);
        }
        newHotel = new Account();
    }

    public void renderToggle(){
        renderFlag = ApexPages.currentPage().getParameters().get('param1');
    }
}