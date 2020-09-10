/**
 * Created by Lenovo on 10.09.2020.
 */

public with sharing class TestInvoke {
    @InvocableMethod
    public static void TestInvocable(){
        System.debug('some text');
    }
}