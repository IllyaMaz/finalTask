public class ContactToManagerController {
    public String message{get;set;}
    private static final String USERPAGE = '/UserPage';
    public PageReference sendEmail(){
        Id userId = ApexPages.currentPage().getCookies().get('UserId').getValue();
        Custom_User__c user = [SELECT State__c,
                                      User_Name__c
                               FROM   Custom_User__c
                               WHERE  id = :userId

        ];
        Custom_User__c manager = [SELECT Email__c
                                  FROM   Custom_User__c
                                  WHERE  State__c = :user.State__c AND Role__c = 'Manager'

        ];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setPlainTextBody(message);
        mail.setSenderDisplayName(user.User_Name__c);
        mail.setToAddresses(new List<String>{'illya.maznychenko@sparkybit.com'});
        List<Messaging.SendEmailResult> qwe = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        return new PageReference(USERPAGE);
    }
    
}