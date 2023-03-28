# Dapper Royalties Metadata

Dapper offers require you to supply royalties for a collection when an offer is created made. 
However, we can't use the royalties metadata standard to provide this information because 
these values must all be merchant addresses. We do not know whether an address is a merchant account or not,
all we can do is check that the address we're given by royalties has a `TokenForwarding.Forwarder` object or not.

This royalties metadata view is a supplement to the actual `MetadataViews.Royalties` view which is meant to return only dapper
merchant accounts for royalties. It can exist on an nft, but given that not all offers belong to a specific item (edition based offers),
we have instead made our example implement this metadata view on the contract level.

Setup is a single transaction, and a contract update.

```cadence
import DapperRoyaltiesMetadata from "../contracts/DapperRoyaltiesMetadata.cdc"

transaction(dict: {Address: UFix64}) {
    prepare(acct: AuthAccount) {
        let royalties = DapperRoyaltiesMetadata.fromDict(dict: dict)
        acct.save(royalties, to: DapperRoyaltiesMetadata.DapperRoyaltiesPath)
    }
}
```

```cadence
    pub fun resolveView(_ view: Type): AnyStruct? {
        switch view {
            case Type<DapperRoyaltiesMetadata.Royalties>():
                if let royalties = self.account.borrow<&DapperRoyaltiesMetadata.Royalties>(from: DapperRoyaltiesMetadata.DapperRoyaltiesPath) {
                    return DapperRoyaltiesMetadata.Royalties(royalties: royalties.getRoyalties())
                } else {
                    return DapperRoyaltiesMetadata.Royalties(royalties: [])
                }
        }
        return nil
    }
```