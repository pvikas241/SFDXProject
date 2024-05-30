@isTest
public class AccountHandlerTest {

    // Test method to ensure account creation works as expected
    @isTest
    static void testCreateAccount() {
        // Start a new test context
        Test.startTest();
        
        // Define a test account name
        String testAccountName = 'Test Account';
        
        // Call the createAccount method from AccountHandler class
        Account createdAccount = AccountHandler.createAccount(testAccountName);
        
        // Stop the test context
        Test.stopTest();
        
        // Query the database to verify the Account was created
        Account queriedAccount = [SELECT Id, Name FROM Account WHERE Id = :createdAccount.Id LIMIT 1];
        
        // Perform assertions to check if the Account was created correctly
        System.assertNotEquals(null, queriedAccount, 'Account should have been created');
        System.assertEquals(testAccountName, queriedAccount.Name, 'Account name should match the test account name');
    }
    
    // Test method to handle the scenario where account name is null or empty
    @isTest
    static void testCreateAccountWithEmptyName() {
        Test.startTest();
        
        // Test with null account name
        try {
            AccountHandler.createAccount(null);
            System.assert(false, 'Exception should have been thrown for null account name');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Account name cannot be null or empty', e.getMessage());
        }

        // Test with empty account name
        try {
            AccountHandler.createAccount('');
            System.assert(false, 'Exception should have been thrown for empty account name');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Account name cannot be null or empty', e.getMessage());
        }
        
        Test.stopTest();
    }
    
    // Test method to ensure the handler can create multiple accounts
    @isTest
    static void testCreateMultipleAccounts() {
        Test.startTest();
        
        String accountName1 = 'Test Account 1';
        String accountName2 = 'Test Account 2';
        
        Account createdAccount1 = AccountHandler.createAccount(accountName1);
        Account createdAccount2 = AccountHandler.createAccount(accountName2);
        
        Test.stopTest();
        
        List<Account> queriedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :new Set<Id>{createdAccount1.Id, createdAccount2.Id}];
        
        System.assertEquals(2, queriedAccounts.size(), 'Two accounts should have been created');
        System.assert(queriedAccounts[0].Name == accountName1 || queriedAccounts[1].Name == accountName1, 'One account should have the name Test Account 1');
        System.assert(queriedAccounts[0].Name == accountName2 || queriedAccounts[1].Name == accountName2, 'One account should have the name Test Account 2');
    }
}
