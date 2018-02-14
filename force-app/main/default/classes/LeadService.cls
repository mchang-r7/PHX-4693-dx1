public with sharing class LeadService {

    /**
     * @return a functional instance
     */
    public static LeadService getInstance() {
        return new LeadService();
    }
    
    /**
     * Given a list of Lead objects, return the corresponding list of Lead
     * records with the Validated Email field set correctly for each lead.
     *
     * @param recordIds
     *
     * @return the list of Lead objects with Email Validation Status set
     */
    public List<Lead> validateEmail(List<Lead> records) {
        
        // Get an instance of `MetasploitService` to do the validation
        MetasploitService metasploit = MetasploitService.getInstance();

        // Validate the email address for each lead in the list
        for (Lead eachRecord : records) {
            eachRecord.HasValidatedEmail__c =
                    metasploit.validateEmail(eachRecord.Email).valid;
        }

        // Return the leads
        return records;
    }
}