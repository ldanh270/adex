const hre = require('hardhat')

async function main() {
    const DSBank = await hre.ethers.getContractFactory('DSBank')
    const dsbank = await DSBank.deploy()

    await dsbank.waitForDeployment()
    console.log(`DSBank deployed to: ${await dsbank.getAddress()}`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
