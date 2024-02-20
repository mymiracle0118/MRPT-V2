// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console2 } from "forge-std/Test.sol";
import { MRPTFactory } from "src/MRPTFactory.sol";
import "src/MRPTToken.sol";
import "forge-std/console.sol";
import "forge-std/console2.sol";

contract MRPTFactoryTest is Test {
    MRPTFactory internal factory;

    uint256 internal mainnetFork;
    string internal MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    uint256 internal bscFork;
    string internal BSC_RPC_URL = vm.envString("OPTIMISM_RPC_URL");

    uint256 internal sepoliaFork;
    string internal SEPOLIA_RPC_URL = vm.envString("SEPOLIA_RPC_URL");

    address alice = address(1);

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        bscFork = vm.createFork(BSC_RPC_URL);
        sepoliaFork = vm.createFork(SEPOLIA_RPC_URL);
    }

    function testMainnetDeploy() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        vm.rollFork(19_196_173);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.envAddress("TOKEN_OWNER");

        factory = new MRPTFactory();

        vm.deal(address(alice), 100 ether);
        vm.startPrank(address(alice));

        bytes32 salt = keccak256(abi.encode("MRPTToken", address(this)));

        bytes memory creationCode = abi.encodePacked(type(MRPTToken).creationCode, abi.encode("Marpto", "MRPT"));

        address computedAddress = factory.computeAddress(salt, keccak256(creationCode));

        address deployedAddress = factory.deploy(owner, 0, salt, creationCode);

        vm.stopPrank();

        assertEq(computedAddress, deployedAddress);
    }

    function testBscDeploy() public {
        vm.selectFork(bscFork);
        assertEq(vm.activeFork(), bscFork);

        vm.rollFork(19_196_173);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.envAddress("TOKEN_OWNER");

        factory = new MRPTFactory();

        vm.deal(address(alice), 100 ether);
        vm.startPrank(address(alice));

        bytes32 salt = keccak256(abi.encode("MRPTToken", address(this)));

        bytes memory creationCode = abi.encodePacked(type(MRPTToken).creationCode, abi.encode("Marpto", "MRPT"));

        address computedAddress = factory.computeAddress(salt, keccak256(creationCode));

        address deployedAddress = factory.deploy(owner, 0, salt, creationCode);

        vm.stopPrank();

        assertEq(computedAddress, deployedAddress);
    }

    function testSepoliaDeploy() public {
        vm.selectFork(sepoliaFork);
        assertEq(vm.activeFork(), sepoliaFork);

        // vm.rollFork(19_196_173);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.envAddress("TOKEN_OWNER");

        factory = new MRPTFactory();

        vm.deal(address(alice), 100 ether);
        vm.startPrank(address(alice));

        bytes32 salt = keccak256(abi.encode("MRPTToken", address(this)));

        bytes memory creationCode = abi.encodePacked(type(MRPTToken).creationCode, abi.encode("Marpto", "MRPT"));

        address computedAddress = factory.computeAddress(salt, keccak256(creationCode));

        address deployedAddress = factory.deploy(owner, 0, salt, creationCode);

        vm.stopPrank();

        assertEq(computedAddress, deployedAddress);
    }
}
