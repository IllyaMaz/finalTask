public  class LogInUser {
        public String username { get; set; }
        public String password { get; set; }
        private static final String USERPAGE = '/UserPage'; 
        private static final String REGISTRATION = '/Registration';
    
          public PageReference login() {
            List<Custom_User__c> userList = new List<Custom_User__c>();
            
            try{
                userList = [SELECT Id,
                                   User_Name__c,
                                   Password__c
                            FROM Custom_User__c
                            WHERE User_Name__c = :username 
                            LIMIT 1
                           ];
            } catch(System.QueryException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ошибка входа. Проверьте введенные данные.'));
                return null;
            }
            
            Custom_User__c user = userList.get(0);
            String secretPassword = RegistrationController.encrypt(password, 'secret');
            DateTime secret = DateTime.now();
            String accessToken = RegistrationController.encrypt('token' , String.valueOf(secret));
            String refreshToken = RegistrationController.encrypt('token' , String.valueOf(secret.addMinutes(1)));
            
            if(user != null && user.Password__c == secretPassword){
                ApexPages.currentPage().setCookies(new Cookie[] {
                    new Cookie('UserId', user.Id, null, 3600, false),
                    new Cookie('Access token', accessToken, null, 1800, false),
                    new Cookie('Refresh token', refreshToken, null, 3600, false)
                  });
              user.Access_token__c = accessToken;
              user.Refresh_token__c = refreshToken;
              update user;
                
                return new PageReference(USERPAGE);
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ошибка входа. Проверьте введенные данные.'));
                return null;
            }
            
          }
        
        public PageReference registration(){
            return new PageReference(REGISTRATION);
        }
    
}