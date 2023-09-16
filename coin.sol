pragma solidity ^0.5.7;

contract coin{
    address public minter;
    mapping(address => uint) public balances;
    event sent(address from,address to,uint amount);
    
    
    constructor() public {
        minter=msg.sender;
    }

    // make new coins and send it to a address
    // only a owner can send these
    function mint(address receiver,uint amount) public
    {
        require(msg.sender==minter);
        balances[receiver]+=amount;
    }

    // send any amount of coins to existing amount
    function send (address receiver,uint amount) public
    {
        require(balances[msg.sender]>amount,"sorry you dont have enough balance...");

        balances[msg.sender]-=amount;
        balances[receiver]+=amount;

        emit sent(msg.sender,receiver,amount);

    }




}

