import "ContractUpdater"

pub struct ContractUpdateReadable {
    pub let name: String
    pub let code: String

    init(
        name: String,
        code: String
    ) {
        self.name = name
        self.code = code
    }
}

/// Returns values of the Updater at the given Address
///
pub fun main(address: Address): {Address: [ContractUpdateReadable]}? {
    let account = getAuthAccount(address)
     
    if let updater = account.borrow<&ContractUpdater.Updater>(from: ContractUpdater.UpdaterStoragePath) {
        let data: {Address: [ContractUpdateReadable]} = {}
        let deployment = updater.getDeployment()

        for contractUpdate in deployment {
            if !data.containsKey(contractUpdate.address) {
                data.insert(key: contractUpdate.address, [])
            }
            data[contractUpdate.address]!.append(
                ContractUpdateReadable(
                    name: contractUpdate.name,
                    code: contractUpdate.stringifyCode()
                )
            )
        }
        
        return data
    }

    return nil

}
