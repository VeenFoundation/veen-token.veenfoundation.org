module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
	networks:{
		azure:{
		host : "veenv3-dns-reg1.eastus.cloudapp.azure.com",
		network_id : 201805,
		port : 8545,
		gas: 4712388
		}
	 }
};
