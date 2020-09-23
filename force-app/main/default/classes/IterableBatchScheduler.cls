/**
 * Created by Lenovo on 13.09.2020.
 */

global with sharing class IterableBatchScheduler implements Schedulable{

    global void execute(SchedulableContext param1) {
        IterableBatchSort i = new IterableBatchSort();
        Database.executeBatch(i);
    }
}