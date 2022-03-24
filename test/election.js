// test code 작성
// 투표 기능을 테스트하기 위해서 “election.js” 테스트 파일에 코드를 추가

// contract를 require로 가져와서 변수에 할당
var Election = artifacts.require("./Election.sol");

// “contract” 함수를 호출하여 callback 함수형태로 테스트를 작성
// 이 callback 함수는 우리 블록체인( Ganache의 ) 모든 accounts들을 “accounts”라는 변수로서 제공
contract("Election", function(accounts) {
  var electionInstance;

  // 후보자 수가 2명이 맞는지 확인하는 테스트
  it("initializes with two candidates", function() {
    return Election.deployed().then(function(instance) {
      return instance.candidatesCount();
    }).then(function(count) {
      assert.equal(count, 2);
    });
  });

  // 각 후보자들의 속성값들을 검증하는 테스트
  it("it initializes the candidates with the correct values", function() {
    return Election.deployed().then(function(instance) {
      electionInstance = instance;
      return electionInstance.candidates(1);
    }).then(function(candidate) {
      assert.equal(candidate[0], 1, "contains the correct id");
      assert.equal(candidate[1], "Candidate 1", "contains the correct name");
      assert.equal(candidate[2], 0, "contains the correct votes count");
      return electionInstance.candidates(2);
    }).then(function(candidate) {
      assert.equal(candidate[0], 2, "contains the correct id");
      assert.equal(candidate[1], "Candidate 2", "contains the correct name");
      assert.equal(candidate[2], 0, "contains the correct votes count");
    });
  });
})