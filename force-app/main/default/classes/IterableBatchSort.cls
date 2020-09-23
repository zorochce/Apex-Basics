
global class IterableBatchSort implements Database.Batchable<Contact> {
    global List<Contact> incomingContacts = new List<Contact>();

    global IterableBatchSort(){

    }

    global IterableBatchSort(List<Contact> contacts) {
        incomingContacts = contacts;
    }

    global System.Iterable<Contact> start(Database.BatchableContext info) {
        return incomingContacts;
    }
    global void execute(Database.BatchableContext info, List<Contact> scope) {
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
    global void finish(Database.BatchableContext info) {
    }
}