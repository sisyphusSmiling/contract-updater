import "DependencyAudit"

transaction() {
    prepare(signer: auth(BorrowValue) &Account) {
        signer.storage.borrow<&DependencyAudit.Administrator>(from: DependencyAudit.AdministratorStoragePath)?.unsetStartEndBlock()
        ?? panic("Could not borrow DependencyAudit.Administrator from signer's storage!")
    }
}
