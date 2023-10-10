import Center from "../../../domain/entities/center";

class CenterDao {
    constructor(
        public id: number,
        public name: string,
        public address: string,
        public insee_code: string
    ) { }

    toEntity() {
        let center = new Center()
        center.id = this.id
        center.name = this.name
        center.address = this.address
        center.inseeCode = this.insee_code
        return center
    }
}

export default CenterDao
