public class PaymentHistoryController {
    private Custom_User__c user = new Custom_User__c();
    private static final String USERPAGE = '/UserPage';

    public PaymentHistoryController(){
        Id userId = ApexPages.currentPage().getCookies().get('UserId').getValue();
        user = [SELECT Id,
                       Debt__c
                FROM   Custom_User__c
                WHERE  Id = :userId
        ]; 
    }

    public List<Payment__c> getPayments(){
        Id ii = user.Id;
        return [SELECT Year__c,
                       Month__c,
                       Sum__c
                FROM   Payment__c
                WHERE  Custom_User__c = :user.Id
        ];
    }

    public PageReference redirectUserPage(){
        return new PageReference(USERPAGE);
    }
}