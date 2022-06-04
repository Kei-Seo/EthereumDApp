pragma solidity >=0.4.22 <0.9.0;
// SPDX-License-Identifier: MIT

contract Work{

    address public owner; // 사장님 나빠여
    address public employee; // 직원

    uint256 public work_start_time; // 일 시작시간
    uint256 public work_end_time; // 일 끝난시간
    //uint256 public work_end_date; // 일이 끝나는 시간

    uint256 public work_total_time; // 누적시간
    uint256 public total_money; // 일을 전부할경우 // 사장님은 입금을 미리해야한다.
    //uint256 public houly_time; // 시금
    
    constructor () public {
        owner = msg.sender;
    }

    struct personHireInfo{
        uint256 work_end_date; // 일이 끝나는 시간
        uint256 houly_time; // 시금
       // uint max_work_day; //일하는날
    }
    mapping(address => personHireInfo) public hireInfo; // 시급 
    mapping(address => uint) public balances; // 잔고

    event hireNewEmployee(address hireAddress, uint256 houly_pay); // 고용주 새로 고용 이벤트
    event eventDepositMoney(address owner, uint256 houly_time, uint work_end); // 고용주가 돈을 미리 입금
    event withdrawMoney(address employee, uint work_time); // 일이 끝나면 직원은 인툴할 수 있다.
    event working(); // 직원이 시급을 올리는 이벤트
   
    enum work_state {
        WORKING, END
    }


    // modifier an_ongoing_work(){
    //     require(block.timestamp <= work_end_date);
    //     _;
    // }

    // modifier an_ongoing_end()
    // {
    //     require(block.timestamp >= work_end_date);
    //     _;
    // }
    
    uint public a = 10;

    function hireEmployee(address _hireAddress, uint256 _houly_pay) public payable returns (bool){
        
        require(owner == msg.sender);
        //require(208 < _day * _houly_pay, "초과근무라서 계약이 성사되지 않았습니다.");
        
        hireInfo[_hireAddress].houly_time = _houly_pay; // 시급 설정
        hireInfo[_hireAddress].work_end_date = 1 weeks + now; // 데이 설정
        //hireInfo[_hireAddress].work_day = _day;


    }

     function getPersonHireInfo(address _hireAddress) public view returns (uint256 _end_date, uint256 _houly_time) {
        personHireInfo memory b = hireInfo[_hireAddress];
        _end_date = b.work_end_date;
        _houly_time = b.houly_time;
        
    }

    
    function getBalanceMoney() public view returns (uint256) {
        return balances[msg.sender];
    }

    function DepositMoneyOwner() public payable{
        //직원 계좌에 입금
        balances[owner] += msg.value;
        //require();
    }

    function WithdrawMoneyEmployee() public {
        //출금
        require(hireInfo[msg.sender].work_end_date < now); // 일이 끝나는날 출금 가능
        require(balances[msg.sender] >= hireInfo[msg.sender].houly_pay * 8); // 출금 금액 제한
        balances[owner] -= _weiToWithdraw;
        owner.transfer(_weiToWithdraw);

    }

    //사장이 입금
    //
    //출근 -> 시간 올라감
    //  
    
    //일을 시작하는 함수
    function startingWork() public returns (bool){
        
        //require(owner == msg.sender, "error here");
        emit working();
        work_start_time = now; // 일한 시간 기록
        
        return true;

    }
    
    // 일을 끝내는 함수
    function endingWork() public returns (uint256){
        
        //require(owner == msg.sender);
        work_end_time = now; // 일한 시간 기록
        work_total_time += work_end_time - work_start_time;
        return work_total_time;
    }


}

// contract MyWork is Work{
    
//     constructor(uint )


// }
