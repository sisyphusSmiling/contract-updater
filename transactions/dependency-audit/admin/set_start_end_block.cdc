import "DependencyAudit"

transaction(start: UInt64, end: UInt64) {
    prepare(signer: auth(BorrowValue) &Account) {
        signer.storage.borrow<&DependencyAudit.Administrator>(from: DependencyAudit.AdministratorStoragePath)?.setStartEndBlock(start: start, end: end)
        ?? panic("Could not borrow DependencyAudit.Administrator from signer's storage!")
    }
}
