
@IsTest
public class TestMyDataFactory {

    public static List<Account> createAccounts(Integer amount, String name) {
        List<Account> newAccounts = new List<Account>();

        for (Integer i = 0; i < amount; i++) {
            newAccounts.add(new Account(Name = name + ' ' + i));
        }
        insert newAccounts;

        return newAccounts;
    }

    public static List<Task> createTasksRelatedToAccounts(List<Account> accounts, Integer amountForOneAccount, String subject) {
        List<Task> oldTasks = new List<Task>();

        for (Integer i = 0; i < accounts.size(); i++) {
            for (Integer j = 0; j < amountForOneAccount; j++) {
                Task task = new Task(Subject = subject, OwnerId = '0052w000005rQI3AAM',
                        WhatId = accounts[i].Id);//system administrator id
                oldTasks.add(task);
            }
        }
        insert oldTasks;

        return oldTasks;
    }

    public static List<Contact> createContactsRelatedToAccounts(List<Account> accounts, Integer amountForOneAccount, String name) {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < accounts.size(); i++) {
            for (Integer j = 0; j < amountForOneAccount; j++) {
                Contact contact = new Contact(LastName = name, AccountId = accounts[i].Id);
                contacts.add(contact);
            }
        }

        insert contacts;

        return contacts;
    }
}