import Brand from "../../../domain/entities/brand";

class BrandDao {
    constructor(
        public id: number,
        public name: string,
        public logo_uri: string
    ) {}

    toEntity() {
        let brand = new Brand()
        brand.id = this.id
        brand.name = this.name
        brand.logoUri = this.logo_uri
        return brand
    }
}

export default BrandDao
