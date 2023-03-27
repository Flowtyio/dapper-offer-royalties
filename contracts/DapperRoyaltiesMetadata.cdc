pub contract DapperRoyaltiesMetadata {
    pub let DapperRoyaltiesPath: StoragePath

    pub struct Royalty {
        // the merchant address to pay royalties to
        pub let addr: Address
        // the number of tokens (NOT percentage) to distribute
        pub let cut: UFix64

        init(addr: Address, cut: UFix64) {
            self.addr = addr
            self.cut = cut
        }
    }

    pub struct Royalties {
        pub let royalties: [Royalty]

        pub fun getRoyalties(): [Royalty] {
            return self.royalties
        }

        init(royalties: [Royalty]) {
            self.royalties = royalties
        }
    }

    pub fun fromDict(dict: {Address: UFix64}): Royalties {
        let royalties: [Royalty] = []

        for k in dict.keys {
            let r = Royalty(addr: k, cut: dict[k]!)
            royalties.append(r)
        }

        return Royalties(royalties: royalties)
    }

    init() {
        let identifier = "DapperRoyaltiesMetadata".concat(self.account.address.toString())
        self.DapperRoyaltiesPath = StoragePath(identifier: identifier)!
    }
}