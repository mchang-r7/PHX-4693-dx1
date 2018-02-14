public virtual class TestService {

    public static Map<Type, TestService> instanceMap =
            new Map<Type, TestService>();

    public void assertJobStatusEquals(
            String expected, SObject record, Schema.SObjectField field,
            Type jobClass) {

        // Construct the message
        List<String> messageParts = new List<String> {
            jobClass.getName(),
            JSON.serialize(this.getLastProcessEvent(jobClass)),
            field.getDescribe().label
        };

        // Perform the assertion
        System.assertEquals(expected, record.get(field),
                String.join(messageParts, '|'));
    }

    public static TestService getInstance(Type serviceType) {

        // Get the instance from the cached map
        TestService instance = instanceMap.get(serviceType);

        // If the instance isn't already cached, instantiate a new instance
        // and then cache it
        if (instance == null) {
            instance = (TestService)serviceType.newInstance();
            instanceMap.put(serviceType, instance);
        }

        // Return the instance
        return instance;
    }

    public ProcessEvent__c getLastProcessEvent(Type jobClass) {
        List<ProcessEvent__c> events = [
            SELECT
                CreatedById,
                CreatedDate,
                EndTime__c,
                EventName__c,
                LastModifiedById,
                LastModifiedDate,
                Message__c,
                Name,
                ProcessName__c,
                Result__c,
                StartTime__c,
                Id
            FROM ProcessEvent__c
            WHERE ProcessName__c = :jobClass.getName()
            ORDER BY CreatedDate DESC
        ];

        return events.isEmpty() ? null : events[0];
    }

    public Lead getLead(String lastName) {
        return [
            SELECT
                Company,
                Email,
                FirstName,
                HasValidatedEmail__c,
                LastName,
                OwnerId,
                ValidateEmailJobStatus__c,
                Id
            FROM Lead
            WHERE LastName = :lastName
        ];
    }

    public class RuntimeException extends System.Exception {}
}