/**
 * Created by Lenovo on 10.09.2020.
 */

global class UpdateAccountWithTasks {
    @InvocableMethod
    public static void updateAccount(List<DataWrapper> incomingData){
        DataWrapper dw = incomingData[0];
        List<Task> tasks = [SELECT Subject FROM Task WHERE AccountId=:dw.accountId];
        if(tasks.size()>3){
            List<User> users = [SELECT Name FROM User];
            Integer randomUserNumber = (Integer)Math.random()*users.size();
            for(Task task:tasks){
                task.OwnerId = users[randomUserNumber].Id;
                task.Description='was updated';
            }
            update tasks;
        } else {
            Task newTask = new Task(Subject = 'Negotiation number ' + tasks.size(),WhatId=dw.accountId);
            insert newTask;
        }

    }

    global class DataWrapper {
        @InvocableVariable(required=true)
        global String  accountId;
    }
}