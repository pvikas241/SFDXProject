@isTest
public class AccountHandlerTest {

    // Test method to ensure account creation works as expected
    @isTest
    static void testCreateAccount() {
        // Define a test account name
        String testAccountName = 'Test Account';
        
        // Call the createAccount method from AccountHandler class
        Account createdAccount = AccountHandler.createAccount(testAccountName);
        
        // Query the database to verify the Account was created
        Account queriedAccount = [SELECT Id, Name FROM Account WHERE Id = :createdAccount.Id LIMIT 1];
        
        // Perform assertions to check if the Account was created correctly
        System.assertNotEquals(null, queriedAccount, 'Account should have been created');
        System.assertEquals(testAccountName, queriedAccount.Name, 'Account name should match the test account name');
    }
}
