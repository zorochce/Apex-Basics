/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public with sharing class TestAccountFutureSort {
    @IsTest
    static void testFutureMethod() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5, 'testFutureMethod');
        TestMyDataFactory.createContactsRelatedToAccounts(oldAccounts, 2, 'testFutureMethod');

        for (Account acc : oldAccounts) {
            acc.BillingStreet = 'testStreet';
        }
        update oldAccounts;

        Test.startTest();
        AccountFutureSort.futureMethod();
        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Processed_By_Future__c,Is_Synced__c FROM Contact WHERE Name = 'testFutureMethod'];

        for (Contact contact : updatedContacts) {
            if (contact.Processed_By_Future__c == false) {
                System.assert(false);
            }
        }
    }
}