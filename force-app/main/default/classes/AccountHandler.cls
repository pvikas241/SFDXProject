public class AccountHandler {
    
    // Method to create a new Account record
    public static Account createAccount(String accountName) {
        // Create a new Account instance
        Account newAccount = new Account(Name = accountName);
        
        // Insert the new Account record into the database
        insert newAccount;
        
        // Return the created Account record
        return newAccount;
    }
}
