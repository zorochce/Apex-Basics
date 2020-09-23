/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public with sharing class TestAccouontQueuebleSort {
    @IsTest
    static void testQueuebleMethodWithBillingAddress() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testQueuebleMethodWithBillingAddress');
        TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testQueuebleMethodWithBillingAddress');

        for (Account acc : oldAccounts) {
            acc.BillingStreet = 'testStreet';
        }
        update oldAccounts;

        Test.startTest();
        System.enqueueJob(new AccountQueuebleSort());
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Processed_By_Queue__c,Is_Synced__c FROM Contact WHERE Name = 'testQueuebleMethodWithBillingAddress'];

        for (Contact contact : updatedContacts) {
            if (contact.Processed_By_Queue__c == false) {
                System.assert(false);
            }
        }
    }

    @IsTest
    static void testQueuebleMethodWithoutBillingAddress() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testQueuebleMethodWithoutBillingAddress');
        TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testQueuebleMethodWithoutBillingAddress');

        Test.startTest();
        System.enqueueJob(new AccountQueuebleSort());
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Processed_By_Queue__c,Is_Synced__c FROM Contact WHERE Name = 'testQueuebleMethodWithoutBillingAddress'];

        for (Contact contact : updatedContacts) {
            if (contact.Processed_By_Queue__c != false) {
                System.assert(false);
            }
        }
    }
}