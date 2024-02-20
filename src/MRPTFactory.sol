// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {console} from "forge-std/console.sol";
import {console2} from "forge-std/console2.sol";
interface IMRPT {
    function transferOwnership(address) external;
}

contract MRPTFactory {

    // address owner;
    // address mrptToken;

    error MRPTFactoryInsufficientBalance(uint256 received, uint256 minimumNeeded);

    error MRPTFactoryEmptyBytecode();

    error MRPTFactoryFailedDeployment();

    constructor() {}

    function deploy(address owner, uint256 amount, bytes32 salt, bytes memory bytecode) external payable returns (address addr) {
        
        if (msg.value < amount) {
            revert MRPTFactoryInsufficientBalance(msg.value, amount);
        }

        if (bytecode.length == 0) {
            revert MRPTFactoryEmptyBytecode();
        }

        assembly {
            addr := create2(amount, add(bytecode, 0x20 ), mload(bytecode), salt)
        }

        IMRPT(addr).transferOwnership(owner);

        if (addr == address(0)) {
            revert MRPTFactoryFailedDeployment();
        }
    }

    function computeAddress(bytes32 salt, bytes32 bytecodeHash) external view returns (address addr) {

        address contractAddress = address(this);
        
        assembly {
            let ptr := mload(0x40)

            mstore(add(ptr, 0x40), bytecodeHash)
            mstore(add(ptr, 0x20), salt)
            mstore(ptr, contractAddress)
            let start := add(ptr, 0x0b)
            mstore8(start, 0xff)
            addr := keccak256(start, 85)
        }
    }

    // function transferOwnership(address _owner) external {
    //     require(msg.sender == owner, "Invalid Owner");
    //     IMRPT(mrptToken).transferOwnership(_owner);
    // }
}