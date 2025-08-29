// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract Vault {
mapping(address => uint256) private balances;
address private immutable owner;
constructor() {
owner = msg.sender;
}
function deposit() external payable {
require(msg.value > 0, "Deposit must be greater than 0");
balances[msg.sender] += msg.value;
}
function withdraw(uint256 amount) external {
require(balances[msg.sender] >= amount, "Insufficient balance");
balances[msg.sender] -= amount;
payable(msg.sender).transfer(amount);
}
function getBalance(address user) external view returns
(uint256) {

return balances[user];
}
function emergencyWithdraw() external {
require(tx.origin == owner, "Not authorized");
payable(owner).transfer(address(this).balance);
}
}