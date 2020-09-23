/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public with sharing class TestAccountFutureSort {
    @IsTest
    static void testFutureMethodWithBillingAddress() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testFutureMethodWithBillingAddress');
        TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testFutureMethodWithBillingAddress');

        for (Account acc : oldAccounts) {
            acc.BillingStreet = 'testStreet';
        }
        update oldAccounts;

        Test.startTest();
        AccountFutureSort.futureMethod();
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Processed_By_Future__c,Is_Synced__c FROM Contact WHERE Name = 'testFutureMethodWithBillingAddress'];

        for (Contact contact : updatedContacts) {
            if (contact.Processed_By_Future__c == false) {
                System.assert(false);
            }
        }
    }

    @IsTest
    static void testFutureMethodWithoutBillingAddress() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testFutureMethodWithoutBillingAddress');
        TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testFutureMethodWithoutBillingAddress');

        Test.startTest();
        AccountFutureSort.futureMethod();
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Processed_By_Future__c,Is_Synced__c FROM Contact WHERE Name = 'testFutureMethodWithoutBillingAddress'];

        for (Contact contact : updatedContacts) {
            if (contact.Processed_By_Future__c != false) {
                System.assert(false);
            }
        }
    }
}