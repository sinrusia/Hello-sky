package main;

public class Account {

	int balance;
	
	public Account(int money){
		balance = money;
	}
	
	public int getBalance(){
		return 0;
	}
	
	public int withdraw(int money){
		balance -= money;
		return money;
	}
	
	public void deposit(int money){
		balance += money;
	}
}
