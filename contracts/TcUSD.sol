// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "./interfaces/ITcUSD.sol";

contract TcUSD is ITcUSD, Ownable, ERC20Burnable {
    constructor() ERC20("TC Dollar", "tcUSD") {}

    // ===== Variables
    uint256 private s_totalSupply;

    // ===== Modifier
    modifier moreThanZero(uint256 _amount) {
        if (_amount <= 0) {
            revert();
        }
        _;
    }

    // ===== Public & External Functions
    function mint(
        address _to,
        uint256 _amount
    ) external onlyOwner moreThanZero(_amount) {
        s_totalSupply += _amount;
        _mint(_to, _amount);
    }

    function burn(
        uint256 _amount
    ) public override onlyOwner moreThanZero(_amount) {
        s_totalSupply -= _amount;
        super.burn(_amount);
    }

    // ===== Getter functions
    function getTotalSupply() public view returns (uint256) {
        return s_totalSupply;
    }
}
