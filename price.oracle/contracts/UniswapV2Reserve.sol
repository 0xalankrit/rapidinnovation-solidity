pragma solidity 0.6.6;

import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "@uniswap/v2-core/contracts/interfaces/IERC20.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "./SafeMath.sol";

contract UniswapV2Reserve{
    using SafeMath for uint256;
    address public pair;
    address public token0;
    address public token1;
    
    address public factory;
    address public REF =0x6B175474E89094C44Da98b954EedeAC495271d0F; // DAI
    // address public REF =0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56; // BUSD
    
    event PriceEvent(uint256 price);

    constructor() public{} 
    
    function setfactory(address _factory) public{
        factory = _factory;
    }
    function getDecimal(address token) public view returns(uint256){
        return IERC20(token).decimals();
    }
    
    function getPrice(address token) external {
        
        pair =IUniswapV2Factory(factory).getPair(token,REF);
        token0 =IUniswapV2Pair(pair).token0();
        token1 =IUniswapV2Pair(pair).token1();

        uint112 reserve0;
        uint112 reserve1;

        (reserve0, reserve1,)=IUniswapV2Pair(pair).getReserves();
        
        uint decimal =getDecimal(token);
        uint integer =18;
        uint value =10**(integer.sub(integer.sub(decimal)));
        
        //         10**18/10**(18-6) ===>>>> 10**(18-(18-6)
        
        if(token ==token1){
            emit PriceEvent((reserve0*value)/reserve1);
        } else if (token ==token0){
            emit PriceEvent((reserve1*value)/reserve0);
        }
    }
}
