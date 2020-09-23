/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public class TestUpdateAccountWithTasks {
    @IsTest
    static void testUpdateAccount() {
        List<Account> newAccounts = new List<Account>();
        List<Task> oldTasks = new List<Task>();

        for (Integer i = 0; i < 3; i++) {
            newAccounts.add(new Account(Name = 'TestUpdateAccountWithTasks ' + i));
        }
        insert newAccounts;

        for (Integer i = 0; i < 3; i++) {
            for (Integer j = 0; j < 3; j++) {
                Task task = new Task(Subject = 'TestUpdateAccountWithTasks',OwnerId='0052w000005rQI3AAM',
                        WhatId=newAccounts[i].Id);//system administrator id
                oldTasks.add(task);
            }
        }

        insert oldTasks;
        System.debug('old tasks : ' + oldTasks);

        List<UpdateAccountWithTasks.DataWrapper> accountsIds = new List<UpdateAccountWithTasks.DataWrapper>();
        for (Account acc : newAccounts) {
            UpdateAccountWithTasks.DataWrapper dw = new UpdateAccountWithTasks.DataWrapper();
            dw.accountId = acc.Id;
            accountsIds.add(dw);
        }

        Test.startTest();
        UpdateAccountWithTasks.updateAccount(accountsIds);
        Test.stopTest();

        List<Task> updatedTasks = [SELECT AccountId,OwnerId,WhatId FROM Task WHERE Subject = 'TestUpdateAccountWithTasks'];
        System.debug('updated tasks : ' +updatedTasks);
        for (Task updatedTask : updatedTasks) {
            for (Task oldTask : oldTasks) {
                if (updatedTask.OwnerId == oldTask.OwnerId && updatedTask.Id == oldTask.Id) {
                    System.assert(false);
                }
            }
        }

    }
}