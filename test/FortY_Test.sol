// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/FortY.sol";

contract FortYTest {
    FortY token; // Instance of the FortY contract

    // Executed before each test
    function beforeEach() public {
        // Deploy the contract with an initial balance of 1000 tokens
        token = new FortY(1000);
    }

    // Check the initial balance
    function testInitialBalance() public {
        uint256 ownerBalance = token.balanceOf(address(this));
        Assert.equal(ownerBalance, 1000 * (10 ** token.decimals()), "Owner should have initial balance of 1000 tokens");
    }

    // Check token transfer
    function testTransfer() public {
        address recipient = address(0x123);
        token.transfer(recipient, 100);

        Assert.equal(token.balanceOf(recipient), 99, "Recipient should receive 99 tokens (after fee)");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    // Check fee modification
    function testSetFeePercentage() public {
        token.setFeePercentage(5);
        Assert.equal(token.feePercentage(), 5, "Fee percentage should be set to 5");

        // Expect an error when trying to set a fee above 20%
        try token.setFeePercentage(21) {
            Assert.ok(false, "Setting fee above 20% should fail");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Fee percentage too high", "Revert reason should be 'Fee percentage too high'");
        }
    }

    function testFeeCalculation() public {
        token.setFeePercentage(10); // Set the fee to 10%
        address recipient = address(0x123);

        token.transfer(recipient, 100);

        Assert.equal(token.balanceOf(recipient), 90, "Recipient should receive 90 tokens after 10% fee");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    function testTransferFrom() public {
        address spender = address(0x456);
        address recipient = address(0x123);

        // Set an allowance for `spender` to transfer 100 tokens on behalf of the owner
        token.approve(spender, 100);

        // `spender` transfers 100 tokens to `recipient`
        token.transferFrom(address(this), recipient, 100);

        // Check balances
        Assert.equal(token.balanceOf(recipient), 99, "Recipient should receive 99 tokens after fee");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    function testAllowance() public {
        address spender = address(0x456);

        // Set an allowance for `spender` to transfer 200 tokens
        token.approve(spender, 200);

        // Check allowance value
        Assert.equal(token.allowance(address(this), spender), 200, "Allowance should be set to 200");
    }

    function testTotalSupply() public {
        uint256 initialSupply = token.totalSupply();
        Assert.equal(initialSupply, 1000 * (10 ** token.decimals()), "Initial total supply should be 1000 tokens");

        // Transfer some tokens and check that totalSupply has not changed
        address recipient = address(0x123);
        token.transfer(recipient, 100);
        Assert.equal(token.totalSupply(), initialSupply, "Total supply should not change after transfer");
    }
}
