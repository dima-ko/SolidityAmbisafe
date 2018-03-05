pragma solidity ^0.4.17;

contract OffChainDebts {
    
    struct Debt {
        string borrowerName;
        uint32 totalAmmount;
        address addr;
    }
    
    event BorrowLogger(string borrowerName, address addr, uint32 ammount);
    mapping (string => Debt) debts;
    address owner;
    
    function OffChainDebts() public {
        owner = msg.sender;
    }

   // Called by borrower. Borrower can borrow multiple times.
   // @param name - name of the borrower
   // @param ammount - money borrowed (in USD)
   function borrow(string borrowerName, uint32 ammount) public {
       if (debts[borrowerName].totalAmmount > 0){
           debts[borrowerName].totalAmmount += ammount;
       } else {
           Debt memory debt;
           debt.borrowerName = borrowerName;
           debt.totalAmmount = ammount;
           debt.addr = msg.sender;
           debts[borrowerName] = debt;
       }
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