pragma solidity >=0.4.22 <0.9.0;

contract Lottery {

    struct BetInfo {
        uint answerBlockNumber;
        address payable bettor;
        byte challenges;
    }

    uint256 private _tail;
    uint256 private _head;
    mapping (uint256 => BetInfo) private _bets;


    address public owner;
    //public 은 자동으로 get을 만들어준다.
    uint256 constant internal BLOCK_LIMIT = 256;
    uint256 constant internal BET_BLOCK_INTERVAL = 3;
    uint256 constant internal BET_AMOUNT = 5 * 10 ** 15;


    uint256 private _pot;
    event BET(uint256 index, address bettor, uint256 amount, byte challenges, uint256 answerBlockNumber);
    enum BlockStatus{checkable, NotReveald, BlockLimitPassed}

    constructor() public {
        // 가장먼저 실행된다.
        owner = msg.sender;
    }


    function getPot() public view returns (uint256 pot){
        return _pot;
    }

    // Bet
    /**
     * @dev 배팅을 한다. 유져는 0.005 ETH를 보내야 하고, 배팅용 1 byte 글자를 보낸다.
     * 큐에 저장된 배팅 정보는 이후 distribute  함수에서 해결된다.
     * @param challenges 유저가 배팅하는 글자
     * @return 함수가 잘 수행되었는지 확인하는 bool값
     */
    function bet(byte challenges) public payable returns (bool result){
        
        //check the proper ether is sent 
        require(msg.value == BET_AMOUNT, "Not enough ETH");
        //push bet to queue
        require(pushBet(challenges), "Fail to add a new Bet Info");
        // emit event 
        emit BET(_tail -1, msg.sender, msg.value, challenges, block.number + BET_BLOCK_INTERVAL);
        return true;
    } 

    // save the bet to the queue

    //distribute 

    function distribute() public {
        // head 3 4 5 6 7 8 9 10 tail
        uint256 cur;
        BetInfo memory b;
        BlockStatus currentBlockStatus;

        for(cur=_head; cur<_tail; cur++){
            b = _bets[cur];
            currentBlockStatus = getBlockStatus(b.answerBlockNumber);
            
            if(currentBlockStatus == BlockStatus.checkable){
                
            }

            if(currentBlockStatus == BlockStatus.NotReveald){
                
            }

            if(currentBlockStatus == BlockStatus.BlockLimitPassed){
                
            }

            // Checkable : block.number > AnswerBlockNumber && block.number < BLOCK_LIMIT + AnswerBlockNumber

            // Not Revealed 

            // Block Limit Passed

        }
    }

    function getBlockStatus(uint256 answerBlockNumber) internal view returns(BlockStatus){
        if (block.number > answerBlockNumber && block.number < BLOCK_LIMIT + answerBlockNumber){
            return BlockStatus.checkable;
        }

        if (block.number <= answerBlockNumber){
            return BlockStatus.NotReveald;
        }

        if (block.number >= answerBlockNumber + BLOCK_LIMIT){
            return BlockStatus.BlockLimitPassed;
        }

        return BlockStatus.BlockLimitPassed;

    }

    //check answer

    function getBetInfo(uint256 index) public view returns (uint256 answerBlockNumber, address bettor, byte challenges){
        BetInfo memory b = _bets[index];
        answerBlockNumber = b.answerBlockNumber;
        bettor = b.bettor;
        challenges = b.challenges;

    }

    function pushBet(byte challenges) internal returns (bool) {
        BetInfo memory b;
        b.bettor = msg.sender;
        b.answerBlockNumber = block.number + BET_BLOCK_INTERVAL;
        b.challenges = challenges;

         _bets[_tail] = b;
        _tail++;

        return true;

    }

    function popBet(uint256 index) internal  returns (bool) {
        delete _bets[index]; //일정량의 가스를 돌려받기위해  
        return true;
    }
 
}