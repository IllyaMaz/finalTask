public with sharing class RegistrationController {
        private Custom_User__c user = new Custom_User__c();
        
        public Custom_User__c getUser(){
            return user;
        }
        
        public PageReference createUser(){
            user.Password__c = encrypt(user.Password__c, 'secret');
            insert user;
            return new PageReference('/');
        }
        
        public static String encrypt(String password, String salt){   
            
            String passwordWithSalt = password + salt;
            
            Blob hashedPassword = Crypto.generateDigest('SHA-256', Blob.valueOf(passwordWithSalt));
            
            String hashedPasswordString = EncodingUtil.base64Encode(hashedPassword);
            return hashedPasswordString;
        }
    
}