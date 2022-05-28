const Lottery = artifacts.require("Lottery");
const assertRevert = require('./assertRevert');
const expectEvent = require('./expectEvent')

contract('Lottery', function([deployer, user1, user2]){ //최대 10개까지 줄수 있음
    //어카운트가 순서대로 들어오게 된다.

    let lottery; // 배포
    let betAmount = 5 * 10 **15; 
    let bet_block_interval = 3;

    beforeEach(async () => {
        lottery = await Lottery.new();
    })

    it('Basis test', async () => {
        console.log('Basis test')
        let owner = await lottery.owner();
        console.log('owner : ', owner);
        // console.log('value : ', value)
        //assert.equal(value, 5)
    })

    it('getPot should return pot', async () => {
        let pot = await lottery.getPot();
        assert.equal(pot, 0)
    })

    describe('Bet', function(){
        it('should fail when the bet money is not 0.005 ETH', async () => {
            // Fail transaction
            await assertRevert(lottery.bet('0xab', {from : user1, value:4000000000000000}))
            // transaction object {chainId, value, to, from, gas, gasPrice}
        })

        it('should put the bet to the bet queue wit 1 bet', async () => {
            //bet
            let receipt = await lottery.bet('0xab', {from : user1, value:betAmount})
            // console.log(recipt)
            let pot = await lottery.getPot();
            assert.equal(pot, 0);

            // check contract balance == 0.005
            let contractBalance = await web3.eth.getBalance(lottery.address);
            assert.equal(contractBalance, betAmount);

            //check bet Info

            let currenBlockNumber = await web3.eth.getBlockNumber();

            let bet = await lottery.getBetInfo(0);
            assert.equal(bet.answerBlockNumber, currenBlockNumber + bet_block_interval);
            assert.equal(bet.bettor, user1);
            assert.equal(bet.challenges, '0xab');

            // check log
            //concole.log(receipt)
            await expectEvent.inLogs(receipt.logs, 'BET')


        })
    })

});