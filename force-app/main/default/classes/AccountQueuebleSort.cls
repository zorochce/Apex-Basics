
public class AccountQueuebleSort implements Queueable {

//без chain нет смысла делать его

    public void execute(QueueableContext context) {
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
            contact.Processed_By_Queue__c = true;
        }
        update contacts;
    }

}