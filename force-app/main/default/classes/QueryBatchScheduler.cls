/**
 * Created by Lenovo on 13.09.2020.
 */

global class QueryBatchScheduler implements Schedulable {

    global void execute(SchedulableContext param1) {
        QueryBatchSort q = new QueryBatchSort();
        Database.executeBatch(q);
    }
}