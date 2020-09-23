/**
 * Created by Lenovo on 13.09.2020.
 */

global class QueryBatchSort implements Database.Batchable<sObject> {
    global String query;

    global QueryBatchSort() {
        query = 'SELECT Id,AccountId FROM Contact WHERE Is_Synced__c = FALSE';
    }
    global QueryBatchSort(String query) {
        this.query = query;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
        //return Database.getQueryLocator([SELECT Id,AccountId FROM Contact WHERE Is_Synced__c = FALSE]);
    }
    //[SELECT Id,AccountId FROM Contact WHERE Is_Synced__c = FALSE]
    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        List<Account> accounts = [
                SELECT BillingState,BillingStreet,BillingGeocodeAccuracy,BillingCountry,BillingPostalCode,BillingCity,
                        BillingLongitude,BillingLatitude
                FROM Account
        ];
        List<Account> accountToUpdate = new List<Account>();
        System.debug(scope);

        for (Contact contact : scope) {
            for (Account account : accounts) {
                if (contact.AccountId == account.Id) {
                    account.Updated_By_Contact__c = true;
                    if (!accountToUpdate.contains(account)) {
                        accountToUpdate.add(account);
                    }

                    contact.Is_Synced__c = true;
                    contact.MailingState = account.BillingState;
                    contact.MailingStreet = account.BillingStreet;
                    contact.MailingGeocodeAccuracy = account.BillingGeocodeAccuracy;
                    contact.MailingCountry = account.BillingCountry;
                    contact.MailingPostalCode = account.BillingPostalCode;
                    contact.MailingCity = account.BillingCity;
                    contact.MailingLongitude = account.BillingLongitude;
                    contact.MailingLatitude = account.BillingLatitude;
                }
            }
        }

        update scope;
        update accountToUpdate;
    }

    global void finish(Database.BatchableContext BC) {
    }
}