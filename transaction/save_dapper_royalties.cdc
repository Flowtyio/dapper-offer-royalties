import DapperRoyaltiesMetadata from "../contracts/DapperRoyaltiesMetadata.cdc"

transaction(dict: {Address: UFix64}) {
    prepare(acct: AuthAccount) {
        let royalties = DapperRoyaltiesMetadata.fromDict(dict: dict)
        acct.save(royalties, to: DapperRoyaltiesMetadata.DapperRoyaltiesPath)
    }
}