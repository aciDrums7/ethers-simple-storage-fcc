import {ethers} from "ethers"
import * as fs from "fs-extra"
import "dotenv/config"

async function main() {
    // the ! means that at compile time that value won't be undefined
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL!)
    // const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
    const encryptedJson = fs.readFileSync("./.encryptedKey.json", "utf-8")
    let wallet = ethers.Wallet.fromEncryptedJsonSync(
        encryptedJson!,
        process.env.PRIVATE_KEY_PASSWORD!
    )
    wallet = await wallet.connect(provider)
    const abi = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.abi",
        "utf-8"
    )
    const binary = fs.readFileSync(
        "./SimpleStorage_sol_SimpleStorage.bin",
        "utf-8"
    )
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
    console.log("Deploying, please wait...")
    const contract = await contractFactory.deploy() // STOP here! Wait for contract to deploy
    console.log(`Contract address: ${contract.address}`)
    const currentFavoriteNumber = await contract.retrieve()
    // JS is dummy with numbers, so to work with solidity he has to adapt with BigNumbers or String
    console.log(`Current Favorite Number: ${currentFavoriteNumber.toString()}`)

    // Solidity is smart enough to get that "7" (string) is the number 7
    const transactionResponse = await contract.store("7")
    const transactionReceipt = await transactionResponse.wait(1)
    const updatedFavoriteNumber = await contract.retrieve()
    console.log(`Updated favorite number is: ${updatedFavoriteNumber}`)

    // deploy a contract? Wait for it to be deployed
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
