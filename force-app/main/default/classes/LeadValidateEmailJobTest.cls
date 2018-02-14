@isTest
private class LeadValidateEmailJobTest {

    private static TestService thisTest =
            TestService.getInstance(TestService.class);

    @testSetup
    private static void setup() {

        // Create leads specifically for this test
        Lead buddy = new Lead(
                FirstName = 'Bugs',
                LastName = 'Bunny (TEST)',
                Company = 'Acme Corporation (TEST)',
                Email = 'bugs@test.acme.com',
                Phone = '+1 (888) NO-REPLY');

        insert new List<Lead> {
            buddy
        };
    }

    @isTest
    private static void validateEmailBugsAtAcmeDotCom() {

        // Given
        Lead givenBuddy = thisTest.getLead('Bunny (TEST)');

        System.assertEquals('bugs@test.acme.com', givenBuddy.Email,
                Schema.SObjectType.Lead.fields.Email.label);

        thisTest.assertJobStatusEquals(
                'Not Started', givenBuddy, Lead.ValidateEmailJobStatus__c,
                LeadValidateEmailJob.class);

        // When
        Test.setMock(HttpCalloutMock.class, new MetasploitServiceMock());
        Test.startTest();

        System.enqueueJob(
                new LeadValidateEmailJob(new List<Id> { givenBuddy.Id }));

        // Then
        Test.stopTest();

        Lead thenBuddy = thisTest.getLead('Bunny (TEST)');

        thisTest.assertJobStatusEquals(
                'Success', thenBuddy, Lead.ValidateEmailJobStatus__c,
                LeadValidateEmailJob.class);
    }
}