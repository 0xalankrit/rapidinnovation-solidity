pragma solidity 0.6.6;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/lib/contracts/libraries/FixedPoint.sol";
import "@uniswap/v2-periphery/contracts/libraries/UniswapV2Library.sol";

contract UniswapV2Twap{
    using FixedPoint for *;
    uint public constant PERIOD =10;
    IUniswapV2Pair public immutable pair;
    address public immutable token0; 
    address public immutable token1;

    uint public price0CumulativeLast; 
    uint public price1CumulativeLast;

    uint32 public blockTimestampLast;
    FixedPoint.uq112x112 public price0Average; 
    FixedPoint.uq112x112 public price1Average;

    constructor(IUniswapV2Pair  _pair) public{
        pair =_pair;
        token0  = _pair.token0();
        token1  = _pair.token1();
        price0CumulativeLast =_pair.price0CumulativeLast();
        // price of token0 denominated in price of token1
        price1CumulativeLast =_pair.price1CumulativeLast();
        (,, blockTimestampLast)= _pair.getReserves();
    } 

    function currentCumulativePrices(address _pair) 
    internal view returns (uint price0Cumulative, uint price1Cumulative, uint32 blockTimestamp) {
        blockTimestamp = uint32(block.timestamp);
        price0Cumulative = IUniswapV2Pair(_pair).price0CumulativeLast();
        price1Cumulative = IUniswapV2Pair(_pair).price1CumulativeLast();

        // if time has elapsed since the last update on the pair, mock the accumulated price values
        (uint112 reserve0, uint112 reserve1, uint32 _blockTimestampLast) = IUniswapV2Pair(pair).getReserves();
        if (_blockTimestampLast != blockTimestamp) {
            // subtraction overflow is desired
            uint32 timeElapsed = blockTimestamp - _blockTimestampLast;
            // addition overflow is desired
            // counterfactual
            price0Cumulative += uint(FixedPoint.fraction(reserve1, reserve0)._x) * timeElapsed;
            // counterfactual
            price1Cumulative += uint(FixedPoint.fraction(reserve0, reserve1)._x) * timeElapsed;
        }
    }
    function update() external{
        ( 
            uint price0Cumulative,
            uint price1Cumulative,
            uint32 blockTimestamp
        ) =currentCumulativePrices(address(pair));
        
        uint timeElapsed =block.timestamp -blockTimestampLast;
        require(timeElapsed>= PERIOD,"time elapsed < min period");

        price0Average =FixedPoint.uq112x112(uint224((price0Cumulative-price0CumulativeLast)/timeElapsed));
        price1Average =FixedPoint.uq112x112(uint224((price1Cumulative-price1CumulativeLast)/timeElapsed));
        price0CumulativeLast =price0Cumulative;
        price1CumulativeLast =price1Cumulative;
        blockTimestampLast =blockTimestamp;
    }

    function consult(address token) external view returns(uint amountOut){
        require(token ==token0 || token ==token1,"Invalid Token");
        if(token ==token0){
            amountOut = price0Average.mul(1e18).decode144();
        }else{
            amountOut = price1Average.mul(1e18).decode144();
        }
    } 

}

// 1425253188563876422791331875
// 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
// 1000000000000000000
// DAI/LINK Pair contract rinkeby 0xc06F69a8b473910ABaC707dbA66bB9Bc4a975c0A