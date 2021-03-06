/**
 * Created by Lenovo on 10.09.2020.
 */

global class UpdateAccountWithTasks {
    @InvocableMethod
    public static void updateAccount(List<DataWrapper> incomingData) {
        List<Task> taskToUpdate = new List<Task>();
        List<Task> taskToInsert = new List<Task>();
        List<Task> allTasks = [SELECT Subject,AccountId,OwnerId FROM Task];
        List<User> users = [SELECT Name FROM User WHERE IsActive = TRUE];
        System.debug('users : ' + users);

        for (DataWrapper dw : incomingData) {
            List<Task> tasks = new List<Task>();
            for(Task task:allTasks){
                if(task.AccountId == dw.accountId){
                    tasks.add(task);
                }
            }
            if (tasks.size() >= 3) {
                Integer randomUserNumber = (Integer) Math.random() * users.size();
                for (Task task : tasks) {
                    while(users[randomUserNumber].Id == task.OwnerId){
                        randomUserNumber = (Integer) Math.random() * users.size();
                    }
                    task.OwnerId = users[randomUserNumber].Id;
                    task.Description = 'was updated';
                }
                taskToUpdate.addAll(tasks);
            } else {
                Task newTask = new Task(Subject = 'Negotiation number ' + tasks.size(), WhatId = dw.accountId);
                taskToInsert.add(newTask);
            }
        }

        insert taskToInsert;
        update taskToUpdate;
    }

    global class DataWrapper {
        @InvocableVariable(required=true)
        global String accountId;
    }
}