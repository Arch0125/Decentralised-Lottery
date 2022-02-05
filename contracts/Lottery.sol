//SPDX-License-Modifier: MIT
pragma solidity ^0.4.17;

contract Lottery{

    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;        
    }

    function enter() public payable {
        require(msg.sender != manager); //manager cannot take part in lottery
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint256){
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public {
        require(msg.sender == manager); //manager can only call pickWinner function
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    function getPlayers() public view returns (address[]){
        return players;
    }
}