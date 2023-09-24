import Model from "../../domain/entities/model";

class ModelDao {
    constructor(
        public id: number,
        public name: string,
        public brand_id: number,
        public type_id: number,
        public release_year: number
    ) { }

    toEntity() {
        let model = new Model()
        model.id = this.id
        model.name = this.name
        model.brandId = this.brand_id
        model.typeId = this.type_id
        model.releaseYear = this.release_year
        return model
    }
}

export default ModelDao
