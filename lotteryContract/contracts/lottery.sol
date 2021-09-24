// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public manager;
    // mapping(address => uint256) public players;
    address payable[] public players;
    
    modifier onlyManagerCalls () {
        require(msg.sender == manager, "only contract initiator can call this");
        _;
    }
    
    constructor() {
        manager = msg.sender;
    }
    function getPlayersList() public view returns( address payable [] memory) { 
        return players;
    }
    function enter() public payable {
        require(msg.value >= 1 ether, "send atleast the minimum amount ");
        // players[msg.sender];
        players.push(payable(msg.sender));
    }
    function  random() private view returns (uint){
        return uint(keccak256(abi.encode(block.difficulty, block.timestamp, players)));
    }
    function pickWinner() public onlyManagerCalls {
        uint winnerIndex = random() % players.length;
    
        //this will return the address of the player then we call the transfer method on address, and balance 
        //this.balance contains the total amount of balance the contract has
        players[winnerIndex].transfer(address(this).balance);
        players = new address payable [](0);
    }
}