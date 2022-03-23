// Election변수에 우리가 작성한 스마트 계약을 항당
var Election = artifacts.require("./Election.sol");

// 해당 변수를 deployer에 추가하여 우리가 migration을 시행할때
//계약이 배초되게끔 한다.

module.exports = function(deployer){
    deployer.deploy(Election);
}
