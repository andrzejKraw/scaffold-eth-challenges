pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  YourToken yourToken;
  uint256 public constant tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfEth, uint256 amountOfTokens);

  constructor(address tokenAddress) public {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 tokensToTransfer = msg.value * tokensPerEth;
    bool sent = yourToken.transfer(msg.sender, tokensToTransfer);
    require(sent, "Something went wrong with transferring tokens");
    emit BuyTokens(msg.sender, msg.value, tokensToTransfer);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH

  function withdraw() public onlyOwner {
    (bool success, ) = msg.sender.call{value: address(this).balance}("");
    require(success, "Something went wrong withdrawing ether");
    
  }
  // ToDo: create a sellTokens() function:


}
