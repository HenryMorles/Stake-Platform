// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contracts/FortY.sol";

contract FortYTest {
    FortY token; // Инстанс контракта FortY

    // Выполняется перед каждым тестом
    function beforeEach() public {
        // Развертываем контракт с начальным балансом 1000 токенов
        token = new FortY(1000);
    }

    // Проверка начального баланса
    function testInitialBalance() public {
        uint256 ownerBalance = token.balanceOf(address(this));
        Assert.equal(ownerBalance, 1000 * (10 ** token.decimals()), "Owner should have initial balance of 1000 tokens");
    }

    // Проверка перевода токенов
    function testTransfer() public {
        address recipient = address(0x123);
        token.transfer(recipient, 100);

        Assert.equal(token.balanceOf(recipient), 99, "Recipient should receive 99 tokens (after fee)");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    // Проверка изменения комиссии
    function testSetFeePercentage() public {
        token.setFeePercentage(5);
        Assert.equal(token.feePercentage(), 5, "Fee percentage should be set to 5");

        // Ожидаем ошибку при попытке установить комиссию выше 20%
        try token.setFeePercentage(21) {
            Assert.ok(false, "Setting fee above 20% should fail");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Fee percentage too high", "Revert reason should be 'Fee percentage too high'");
        }
    }

    function testFeeCalculation() public {
        token.setFeePercentage(10); // Устанавливаем комиссию 10%
        address recipient = address(0x123);

        token.transfer(recipient, 100);

        Assert.equal(token.balanceOf(recipient), 90, "Recipient should receive 90 tokens after 10% fee");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    function testTransferFrom() public {
        address spender = address(0x456);
        address recipient = address(0x123);

        // Устанавливаем разрешение для `spender` на перевод 100 токенов от имени владельца
        token.approve(spender, 100);

        // `spender` переводит 100 токенов `recipient`
        token.transferFrom(address(this), recipient, 100);

        // Проверка балансов
        Assert.equal(token.balanceOf(recipient), 99, "Recipient should receive 99 tokens after fee");
        Assert.equal(token.balanceOf(address(this)), 900, "Owner should have 900 tokens left");
    }

    function testAllowance() public {
        address spender = address(0x456);

        // Устанавливаем разрешение для `spender` на перевод 200 токенов
        token.approve(spender, 200);

        // Проверяем значение allowance
        Assert.equal(token.allowance(address(this), spender), 200, "Allowance should be set to 200");
    }

    function testTotalSupply() public {
        uint256 initialSupply = token.totalSupply();
        Assert.equal(initialSupply, 1000 * (10 ** token.decimals()), "Initial total supply should be 1000 tokens");

        // Переводим часть токенов и проверяем, что totalSupply не изменился
        address recipient = address(0x123);
        token.transfer(recipient, 100);
        Assert.equal(token.totalSupply(), initialSupply, "Total supply should not change after transfer");
    }
}