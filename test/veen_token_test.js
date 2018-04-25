var VeenCoin = artifacts.require("Veen");

contract("Veen", function(accounts){
    it("should put 15000000000 veen tokens in the contract owner", function(){
        return VeenCoin.deployed().then(function(instance){
            return instance.balanceOf.call(accounts[0]);
        }).then(function(balance){
            assert.equal(balance.valueOf(), 15000000000, "15000000000 wansn't in the contract owner");
        });
    })
    it("should send coin correctly", function(){
        var meta;
        var account_one = accounts[0];
        var account_two = accounts[1];

        var account_one_starting_balance;
        var account_two_starting_balance;
        var account_one_ending_balance;
        var account_two_ending_balance;

        var amount = 300;

        return VeenCoin.deployed().then(function(instance){
            meta = instance;
            return meta.balanceOf.call(account_one);
        }).then(function(balance){
            account_one_starting_balance = balance.toNumber();
            return meta.balanceOf.call(account_two);
        }).then(function(balance){
            account_two_starting_balance = balance.toNumber();
            return meta.transfer(account_two, amount);
        }).then(function(){
            return meta.balanceOf.call(account_one);
        }).then(function(balance){
            account_one_ending_balance = balance.toNumber();
            return meta.balanceOf.call(account_two);
        }).then(function(balance){
            account_two_ending_balance = balance.toNumber();

            assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
            assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
        });
    }); 
});