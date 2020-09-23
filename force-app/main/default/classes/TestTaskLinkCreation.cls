/**
 * Created by Lenovo on 23.09.2020.
 */
@IsTest
public with sharing class TestTaskLinkCreation {
    @IsTest
    static void testCreateTaskAndLink() {
        List<Account> newAccounts = TestMyDataFactory.createAccounts(10,'testCreateTaskAndLink');

        List<TaskLinkCreation.DataWrapper> accountsIds = new List<TaskLinkCreation.DataWrapper>();
        for (Account acc : newAccounts) {
            TaskLinkCreation.DataWrapper dw = new TaskLinkCreation.DataWrapper();
            dw.accountId = acc.Id;
            accountsIds.add(dw);
        }

        Test.startTest();
        TaskLinkCreation.createTaskAndLink(accountsIds);
        Test.stopTest();

        List<Task> createdTask = [SELECT Id,Subject,WhatId FROM Task WHERE Subject LIKE 'Negotiation with%'];
        System.debug(createdTask);

        Boolean contain = false;
        for (TaskLinkCreation.DataWrapper dw : accountsIds) {
            for (Task task : createdTask) {
                if(dw.accountId == task.WhatId){
                    contain = true;
                }
            }
            if(!contain){
                System.assert(false);
            }

            contain = false;
        }
    }

}