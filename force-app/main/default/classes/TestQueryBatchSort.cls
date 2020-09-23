/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public with sharing class TestQueryBatchSort {
    @IsTest
    static void testQueryBatchMethodWithBillingAddress(){
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testQueuebleMethodWithBillingAddress');
        List<Contact> oldContacts = TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testQueuebleMethodWithBillingAddress');

        for(Contact contact:oldContacts){
            contact.Is_Synced__c = false;
        }

        for(Account account:oldAccounts){
            account.BillingStreet = 'testStreet';
        }
        update oldContacts;
        update oldAccounts;

        Test.startTest();
        Database.executeBatch(new QueryBatchSort());
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT LastName,Is_Synced__c,MailingStreet FROM Contact WHERE LastName = 'testQueuebleMethodWithBillingAddress'];
        List<Account> updatedAccounts = [SELECT Updated_By_Contact__c FROM Account WHERE Name = 'testQueuebleMethodWithBillingAddress'];
        System.debug(oldContacts);
        System.debug(updatedContacts);
        System.debug(updatedAccounts);
        for (Contact contact : updatedContacts) {
            System.assert(contact.Is_Synced__c);
            if (contact.MailingStreet != 'testStreet') {
                System.assert(false);
            }
        }
        for(Account acc:updatedAccounts){
            System.assert(acc.Updated_By_Contact__c);
        }
    }
}