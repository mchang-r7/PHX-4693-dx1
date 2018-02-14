public with sharing class LeadValidateEmailJob
        extends AbstractProfiledAsyncJob
        implements Database.AllowsCallouts {
    
    private List<Id> recordIds;

    public LeadValidateEmailJob(List<Id> recordIds) {
        this.recordIds = recordIds;
    }

    public override void execute() {

        LeadService sfdcLead = LeadService.getInstance();

        DatabaseService.getInstance().updateAllowSave(
                AsyncJobUtil.stampSuccess(
                        sfdcLead.validateEmail(this.recordIds),
                        Schema.Lead.ValidateEmailJobStatus__c));
    }

    public override void finishSuccess() {
        /* do nothing */
    }

    public override void finishError(System.Exception e) {
        List<Lead> errors = [
            SELECT Id
            FROM Lead
            WHERE Id IN :this.recordIds
        ];

        DatabaseService.getInstance().updateAllowSave(
                AsyncJobUtil.stampError(
                        errors, Schema.Lead.ValidateEmailJobStatus__c));
    }

    public override String getClassName() {
        return LeadValidateEmailJob.class.getName();
    }
}