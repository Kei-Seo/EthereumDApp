
//스마트 계약은 솔리디티 version을 선언하는 pragma로 시작
pragma solidity >=0.4.22 <0.8.0;
contract Election {
    //Read/ write candiate
    //candidate 이름으로 저장할 string 변수 선언
    // public으로 선언하면 solidity 가 
    //"공짜"로 해당 변수 내용을 조회할 수 있는 getter 함수를 제공
    string public candidate;

    //Constructor
    //constructor 함수는 스마트 계약이 블록체인이 배포될때 
    //최초에 한번 실행
    //우리가 미리 세팅하고자 하는 변수는 migration을 통해 블록체인에 저장

    function Election() public {
        candidate = "Candidate 1";
    }


}