
global class IterableBatchSort implements Database.Batchable<Contact> {
    global System.Iterable<Contact> start(Database.BatchableContext info) {
        return  new List<Contact>();
    }
    global void execute(Database.BatchableContext info, List<Contact> scope) {
        List<Account> accounts = new List<Account>();
        for (Contact contact : scope) {
            Account account = [SELECT BillingAddress FROM Account WHERE Id = :contact.AccountId LIMIT 1];
            account.Updated_By_Contact__c = false;

            accounts.add(account);

            contact.Is_Synced__c = true;
            contact.MailingState = account.BillingState;
            contact.MailingStreet = account.BillingStreet;
            contact.MailingGeocodeAccuracy = account.BillingGeocodeAccuracy;
            contact.MailingCountry= account.BillingCountry;
            contact.MailingPostalCode = account.BillingPostalCode;
            contact.MailingCity= account.BillingCity;
            contact.MailingLongitude= account.BillingLongitude;
            contact.MailingLatitude= account.BillingLatitude;
            System.debug(contact.MailingAddress);
        }
        update scope;
        update accounts;
    }
    global void finish(Database.BatchableContext info) {
    }
}