// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";


contract FortY is ERC20, Ownable, Pausable {
    uint256 public feePercentage = 1;   // Fee percentage for transfers (1% by default)

    constructor(uint256 initialSupply) ERC20("FortY", "FRTY") Ownable(msg.sender) {
    _mint(msg.sender, initialSupply * (10 ** decimals()));
    }


    function transfer(address to, uint256 amount) public override whenNotPaused returns (bool) {
        // Calculate the fee based on the fee percentage
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;

        // Transfer the fee to the owner
        _transfer(_msgSender(), owner(), fee);
        _transfer(_msgSender(), to, amountAfterFee);

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override whenNotPaused returns (bool) {
        // Calculate the fee based on the fee percentage
        uint256 fee = (amount * feePercentage) / 100;
        uint256 amountAfterFee = amount - fee;

        // Ensure the sender has sufficient allowance
        uint256 currentAllowance = allowance(from, _msgSender());
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _approve(from, _msgSender(), currentAllowance - amount);

        // Transfer the fee to the owner
        _transfer(from, owner(), fee);
        _transfer(from, to, amountAfterFee);

        return true;
    }

    function setFeePercentage(uint256 _newFee) external onlyOwner {
        require(_newFee <= 20, "Fee percentage too high");  // Ensure that the fee is not greater than 20%
        feePercentage = _newFee;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}
