pragma solidity >=0.4.25 <0.6.0;

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract Betting {
  // 最小投注额
  uint constant MIN_BET = 0.01 ether;
  // 最大投注额
  uint constant MAX_BET = 100 ether;
  // 交易抽成金额
  uint constant DRAW_AMOUNT = 0.0001 ether;

  uint constant MAX_MODULO = 2;
  uint constant MAX_BET_MASK = 2 ** MAX_MODULO;

  struct Bet{
    address sender; // 投注方
    uint8 modulo; // 投注类型
    uint amount; // 投注金额
    uint mask; // 投注点数
    uint seed; // 随机种子
    uint blockNumber; // 下注时的区块号
  }

  /**
   * 下注列表
   * key为下注时的seed
   */
  mapping(uint=>Bet) bets;

  /**
   * 下注
   */
  function placeBet(uint8 modulo,uint mask,uint seed) external payable{
    // 查看是否已经下注
    Bet storage bet = bets[seed];
    require(bet.sender == address(0), "已下注,无法重复下注");
    require(msg.value >= MIN_BET && msg.value <= MAX_BET, "超出下注范围");
    require(modulo >= 2 && modulo <= MAX_MODULO, "超出modulo范围");
    require(mask > 0 && mask < MAX_BET_MASK, "超出mask范围");
    
    (possibleWinAmount, jackpotFee) = getWinAmount(msg.value, modulo, rollUnder);

    // Enforce max profit limit.
    require(possibleWinAmount <= msg.value + maxProfit, "maxProfit limit violation.");


  }

  /**
   * 
   */
  function getWinAmount() private pure{
    
  }
}
