package main;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

public class AccountTest extends TestCase {

	Account account;
	
	protected void setUp() throws Exception{
		account = new Account(10000);
	}
	
	protected void tearDown() throws Exception {
		super.tearDown();
	}
	
	public void testAccount() {
		fail("Not yet implemented"); // TODO 생성자 테스트 작성
	}

	public void testGetBalance() {
		assertEquals(10000, account.getBalance());
	}

	public void testWithdraw() {
		fail("Not yet implemented");
	}

	public void testDeposit() {
		fail("Not yet implemented");
		
		List<Account> l = new ArrayList<Account>();
		
		for(Account account : l){
			account.getBalance();
		}
		
	}

}
