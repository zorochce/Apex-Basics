/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public class TestUpdateAccountWithTasks {
    @IsTest
    static void testUpdateAccount() {
        List<Account> oldAccounts = TestMyDataFactory.createAccounts(5,'createAccountsWithTasks');
        List<Task> oldTasks = TestMyDataFactory.createTasksRelatedToAccounts(oldAccounts,3,'createAccountsWithTasks');
        System.debug('old tasks : ' + oldTasks);

        List<UpdateAccountWithTasks.DataWrapper> accountsIds = new List<UpdateAccountWithTasks.DataWrapper>();
        for (Account acc : oldAccounts) {
            UpdateAccountWithTasks.DataWrapper dw = new UpdateAccountWithTasks.DataWrapper();
            dw.accountId = acc.Id;
            accountsIds.add(dw);
        }

        Test.startTest();
        UpdateAccountWithTasks.updateAccount(accountsIds);
        Test.stopTest();

        List<Task> updatedTasks = [SELECT AccountId,OwnerId,WhatId FROM Task WHERE Subject = 'createAccountsWithTasks'];
        System.debug('updated tasks : ' + updatedTasks);
        for (Task updatedTask : updatedTasks) {
            for (Task oldTask : oldTasks) {
                if (updatedTask.OwnerId == oldTask.OwnerId && updatedTask.Id == oldTask.Id) {
                    System.assert(false);
                }
            }
        }

    }
}