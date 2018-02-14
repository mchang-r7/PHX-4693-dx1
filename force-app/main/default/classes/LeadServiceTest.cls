@isTest
private class LeadServiceTest {

    @isTest
    private static void validateEmailSuccess() {

        // Given
        Lead givenBugs = new Lead(
                Company = 'Acme Corporation (TEST)',
                Email = 'bugs@test.acme.com',
                FirstName = 'Bugs',
                LastName = 'Bunny (TEST)');

        System.assertEquals(false, givenBugs.HasValidatedEmail__c,
                Schema.SObjectType.Lead.fields.HasValidatedEmail__c.label);
        
        // When
        Test.startTest();

        Lead whenBugs = LeadService.getInstance().validateEmail(
                new List<Lead> { givenBugs }).get(0);
        
        // Then
        Test.stopTest();

        System.assertEquals(true, whenBugs.HasValidatedEmail__c,
                Schema.SObjectType.Lead.fields.HasValidatedEmail__c.label);
    }
}