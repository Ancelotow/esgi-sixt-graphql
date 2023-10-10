import Town from "../../../domain/entities/town";

class TownDao {
    constructor(
        public insee_code: string,
        public name: string,
        public zip_code: string
    ) { }

    toEntity() {
        let town = new Town()
        town.inseeCode = this.insee_code
        town.name = this.name
        town.zipCode = this.zip_code
        return town
    }
}

export default TownDao
