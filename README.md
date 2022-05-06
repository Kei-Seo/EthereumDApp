## 이더리움  DApp 개발
  * # How to Build Ethereum Dapp 

  * ## 본 예제는 Solidity, JavaScript를 사용합니다.

  * ### 블록체인에 내가 누구를 뽑았는지 저장하고 배포해보자!

  * #### 쌉가이즈 졸업프로젝트 대상 가자!

  * ##### 222222222222222

  * ###### 2222222222222222222

## 일단 전부 기록하자
  
***


> DID

>> Decentralized Application Development Tutorial

## 목록 (List)

* Using Tool
  * MetaMask
  * Ganache
  * Node
  * Truffle

* Vote Testing 방법
  1. truffle console
  2. Election.deployed().then(function(instance) { app = instance })
  3. app.candidate()


## 코드 (Code)



* Election.sol
```
pragma solidity >=0.4.22 <0.8.0;
contract Election {
    string public candidate;
    function Election() public {
        candidate = "Candidate 1";
    }
}
```

* constructor > function Election `Election.deployed().then(function(instance) { app = instance })` 

## 강의 링크

* <https://youtu.be/3681ZYbDSSk>
* [YouTube](https://youtu.be/3681ZYbDSSk)

## 강조

* 강조 문법 **강조된 부분** 예시입니다.

## 이미지

![예시 이미지](https://raw.githubusercontent.com/ByungJun25/Wiki/master/Markdown/example_image.jpg)
