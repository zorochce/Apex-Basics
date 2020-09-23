/**
 * Created by Lenovo on 11.09.2020.
 */

public with sharing class AccountFutureSort {
    @future
    public static void futureMethod(){
        List<Account> accounts = [SELECT BillingAddress, (SELECT Id FROM Contacts) FROM Account LIMIT 150];
        List<Contact> contacts = new List<Contact>();

        System.debug(accounts);

        for(Account account:accounts){
            if(account.BillingAddress != null){
                contacts.addAll(account.Contacts);
            }
        }

        System.debug(contacts);

        for(Contact contact:contacts){
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        update contacts;
    }
}