pragma solidity ^0.5.7;

contract will{
    address owner;
    uint fortune;
    bool deceased;
    uint i;

    constructor() payable public {
        owner=msg.sender;
        fortune=msg.value;
        deceased=false;
    }  

    // creating modifiers only owner ...only owner can all the contract
    modifier only_owner{
        require(msg.sender == owner);
        _;
    }

    // funds allocated if a person is dead
    modifier only_dead{
        require(deceased == true);
        _;
    }

    address payable [] family_wallets;
    mapping(address => uint) inheritance;

    // function for a person to div his money to next generations
    function set_Inheritance (address payable wallet,uint amount) public  payable only_owner
    {
        family_wallets.push(wallet);
        inheritance[wallet]=amount;
    }

    // automated payment for each family member after person gets deseaced
    function pay() private only_dead
    {
        for(i=0;i<family_wallets.length;i++)
        {
            family_wallets[i].transfer(inheritance[family_wallets[i]]);
        }
    }

    function person_is_dead() public only_owner
    {
        deceased=true;
        pay();
    }
}