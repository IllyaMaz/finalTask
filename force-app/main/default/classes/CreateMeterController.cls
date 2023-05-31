public class CreateMeterController {
    private Meter__c meter = new Meter__c();
    private static final String USERPAGE = '/UserPage';

    public Meter__c getMeter(){
        return meter;
    }

    public PageReference saveMeter(){
        Custom_User__c user = new Custom_User__c();
        user.Id = ApexPages.currentPage().getCookies().get('UserId').getValue();
        meter.Custom_User__c = user.Id;

        Date today = Date.today();
        if(meter.Year__c == today.year() && meter.Month__c == today.month()-1){

            List<Custom_User__c> userList = [SELECT Id,
                                                    State__c,
                                                    City__c,
                                                    Debt__c
                                             FROM   Custom_User__c
                                             WHERE  id = :user.Id     
                                             LIMIT  1
            ];
            user = userList.get(0);

            List<Region_City_Rate__c> rateList = [SELECT Gas__c,            
                                                     Water__c,
                                                     Electricity__c
                                              FROM   Region_City_Rate__c
                                              WHERE  State__c = :user.State__c AND City__c = :user.City__c
            ];
            Region_City_Rate__c rate = rateList.get(0);

            user.Monthly_Payment__c = meter.Gas__c * rate.Gas__c + meter.Water__c * rate.Water__c + meter.Electricity__c * rate.Electricity__c;
            user.Debt__c += user.Monthly_Payment__c;
        }
        
        insert meter;
        update user;

        return new PageReference(USERPAGE);
    }


    
}