pragma solidity ^0.4.17;

contract OffChainDebts {
    
    struct Debt {
        string borrowerName;
        uint8 ammount;
        address addr;
    }
    
    event BorrowLogger(string borrowerName, address addr, uint8 ammount);
    mapping (string => Debt) debts;
    address owner;
    
    function OffChainDebts() public {
        owner = msg.sender;
    }

   // Called by borrower
   // @param name - name of the borrower
   // @param ammount - money borrowed (in USD)
   function borrow(string borrowerName, uint8 ammount) public {
       Debt memory debt;
       debt.borrowerName = borrowerName;
       debt.ammount = ammount;
       debt.addr = msg.sender;
       debts[borrowerName] = debt;
       BorrowLogger(borrowerName, msg.sender, ammount);
   }
   
   // Called by owner of the contract (and also owner of the debts)  
   // when borrower repays the debt
   // @param name - name of the borrower
   function repay(string name) public {
       require(owner == msg.sender);
       delete debts[name];
   }
   
   
}