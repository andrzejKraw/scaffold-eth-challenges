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

  function buyTokens() public payable {
    uint256 tokensToTransfer = msg.value * tokensPerEth;
    bool sent = yourToken.transfer(msg.sender, tokensToTransfer);
    require(sent, "Something went wrong with token transfer");
    emit BuyTokens(msg.sender, msg.value, tokensToTransfer);
  }

  // disabling withdrawals for liquidity preserving
  
  // function withdraw() public onlyOwner {
  //   (bool success, ) = msg.sender.call{value: address(this).balance}("");
  //   require(success, "Something went wrong withdrawing ether");
  // }

  function sellTokens(uint256 amount) public {
    bool tokensSent = yourToken.transferFrom(msg.sender, address(this), amount);
    require(tokensSent, "Something went wrong with token transfer");
    (bool success, ) = msg.sender.call{value: amount/tokensPerEth}("");
    require(success, "Something went wrong with ether transfer");
  }
}
