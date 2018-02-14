public without sharing class DatabaseService {

    public static DatabaseService getInstance() {
        return new DatabaseService();
    }

    /**
     * Emulates the naive `update` operation but defaults to allowing
     * duplicate records to be saved.
     *
     * @param records The list of records to update
     *
     * @throws System.Exception just like naive `update`
     */
    public void updateAllowSave(List<SObject> records) {
        this.updateAllowSave(records, new Database.DMLOptions());
    }

    /**
     * Emulates the naive `update` operation but defaults to allowing
     * duplicate records to be saved.
     *
     * @param records The list of records to update
     * @param options The options to use when updating the records
     *
     * @throws System.Exception just like naive `update`
     */
    public void updateAllowSave(
            List<SObject> records, Database.DMLOptions options) {

        // Always allow saving duplicate records
        options.duplicateRuleHeader.allowSave = true;
        options.optAllOrNone = true;  // cause errors to be thrown

        // Update records and throw exceptions
        Database.update(records, options);
    }
    
    public static void updateSaveWithoutRule(List<SObject> records) {
        // Update records and throw exceptions
        Database.update(records);
    }
}