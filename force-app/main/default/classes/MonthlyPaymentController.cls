public  class MonthlyPaymentController {
    private static final String USERPAGE = '/UserPage';
    private Payment__c pay = new Payment__c();
    private Custom_User__c user = new Custom_User__c();

    public Custom_User__c getUsers(){
        Id userId = Apexpages.currentPage().getCookies().get('UserId').getValue();
        List<Custom_User__c> userList = [SELECT Debt__c
                                         FROM   Custom_User__c
                                         WHERE  Id = :userId
                                        ];
        user = userList.get(0); 
        return user;
    }

    public Payment__c getPayment(){
        return pay;
    }

    public PageReference doPay(){
        user.Debt__c = user.Debt__c - pay.Sum__c;
        pay.Custom_User__c = user.Id;
        update user;
        insert pay;
        return new PageReference(USERPAGE);
    }


}