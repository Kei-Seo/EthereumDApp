pragma solidity ^0.6.2;

//스마트 컨트렉트 데이터 구조를 정의하고 테스트
contract BallotV1{
    
    struct Voter {
        uint weight;
        bool vooted;
        uint vote;
    }

    struct Proposal{
        uint voteCount;
        //제안의 상세정보를 가지고있다.
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    enum Phase {Init, Regs, Vote, Done}
    Phase public state = Phase.Done;

} 
