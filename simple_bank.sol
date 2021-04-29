// Declare the source file for the compiler
pragma solidity ^0.6.6;


/// @title simple_bank.sol
/// @author Ibrahima Sory Diallo
/// @notice this contract simulate a simple banc account where the user will be able to withdrw, deposit ,and tranfer
/// @dev the language used build this contract is the solidity language ^0.6.6


contract SimpleBank{ // Contracts name always starts with capitals latters
//diccioanry that map user address with balances
//careful here with overflow attacks with numbers
//private mean that  others contracts cannot dirrectly access the data withing this contract but still viewable to others parties withing 
mapping( address => uint) private balances;

// public from the outside but not writable
 address public owner;

//Events: publicise events to external listeners
 event LogDepositeMade(address accounAddress,uint amount);

//Contructor , can receave one or many parameters 
 constructor() public {
     //msg provides details about the message that is sents to the contract 
     //msg.sender is the contract caller (address of contract creator)
     owner = msg.sender;
 }

 /// @notice Deposite ether into bank
 /// @return Return the user balance after the deposit is made
 function deposit() public payable returns (uint){
     //use require to test user inputs
     //here we are making sure that there is not a overflow issue
     require(balances[msg.sender]+msg.value >= balances[msg.sender]);
     // update the user balance
     balances[msg.sender]+=msg.value;

     //notifiy the user that the deposit is made
     emit LogDepositeMade(msg.sender, msg.value); // fire the even
     return balances[msg.sender];
 }


 ///@notice withdraw eth from bank
 ///@param amount of eth to withdraw from bank
 ///@return remainig_balance
 function withdraw(uint amount) public returns (uint remainig_balance){
     require(balances[msg.sender]>= amount);
     // update the balance
     balances[msg.sender]-=amount;
     // this automaticaly throw on a failure , wiche mean the updated balance is reverted
     msg.sender.transfer(amount);
     return balances[msg.sender];
 }
 ///@notice get the user balance
 ///@return  user_balance 
 function balance () view public returns (uint user_balance) {
     return balances[msg.sender];
 }
}

