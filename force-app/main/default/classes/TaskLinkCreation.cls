/**
 * Created by Lenovo on 10.09.2020.
 */

global class TaskLinkCreation {
    @InvocableMethod(label='Create task with link')
    global static void createTaskAndLink(List<DataWrapper> incomingData) {
        Task task = new Task();

        DataWrapper dw = incomingData[0];

        Account account = [SELECT Name FROM Account WHERE Id = :dw.accountId];
        task.Subject = 'Negotiation with ' + account.Name;
        task.WhatId = dw.accountId;
        insert task;
    }

    global class DataWrapper  {
        @InvocableVariable(required=true)
        global String  accountId;
    }

}



