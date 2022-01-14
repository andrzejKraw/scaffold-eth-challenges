pragma solidity >=0.6.0 <0.7.0;

contract ExampleExternalContract {

  bool public completed = false;

  function checkCompleted() public view returns (bool) {
    return completed;
  }
  
  function complete() public payable {
    completed = true;
  }

}
