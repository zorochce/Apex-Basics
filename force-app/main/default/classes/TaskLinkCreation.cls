/**
 * Created by Lenovo on 10.09.2020.
 */

global class TaskLinkCreation {
    @InvocableMethod(label='Create task with link')
    global static void createTaskAndLink(List<DataWrapper> incomingData) {
        List<Account> accounts = [SELECT Id,Name FROM Account];
        List<Task> taskToAdd = new List<Task>();

        for(Account acc:accounts){
            for(DataWrapper dw:incomingData){
                if(dw.accountId == acc.Id){
                    Task task = new Task();
                    task.Subject = 'Negotiation with ' + acc.Name;
                    task.WhatId = acc.Id;
                    taskToAdd.add(task);
                }
            }
        }
        System.debug(taskToAdd);
        insert taskToAdd;
    }

    global class DataWrapper  {
        @InvocableVariable(required=true)
        public  String  accountId;
    }

}



