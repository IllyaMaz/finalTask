public class UserPageController {
    private static final String CREATEMETER = '/CreateMeter';
    private static final String MONTHLYPAYMENT = '/MonthlyPayment';
    private static final String PAYMENTHISTORY = '/PaymentHistory';
    private static final String CONTACTMANAGER = '/ContactToManager';

    public Custom_User__c getUsers(){
        Id userId = ApexPages.currentPage().getCookies().get('UserId').getValue();
        return [SELECT User_Name__c,
                       State__c,
                       City__c,
                       Debt__c,
                       Monthly_Payment__c
                FROM   Custom_User__c
                WHERE  Id = :userId
        ];
    }

    public PageReference redirectCreateMeter(){
        return new PageReference(CREATEMETER);
    }

    public PageReference redirectMonthlyPayment(){
        return new PageReference(MONTHLYPAYMENT); 
    }

    public PageReference redirectPaymentHistory(){
        return new PageReference(PAYMENTHISTORY);
    }

    public PageReference redirectContactManeger(){
        return new PageReference(CONTACTMANAGER);
    }
}