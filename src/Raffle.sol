// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title Raffle Contract
 * @author Daryle Tan
 * @notice This is a contract for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */
contract Raffle {
    error Raffle__NotEnoughEthSent();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;

    /** Events */
    event EnteredRaffle(address indexed player);

    constructro( uint256 entranceFee, uint256 interval ) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payanle{
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!");
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        s_players.push(payable(msg.sender));
    
        emit EnteredRaffle(msg.sender);
    }

    function pickWinner() public {
       if (( block.timestamp - s_lastTimeStamp) < i_interval) {
        revert Raffle__NotEnoughEthSent();
       }

    }

    function getEntranceFee() external view returns(uint256) {
        return i_entranceFee;
    }
}