import VehicleType from "../../../domain/entities/vehicleType";

class VehicleTypeDao {
    constructor(
        public id: number,
        public name: string
    ) {}

    toEntity() {
        let vehicleType = new VehicleType()
        vehicleType.id = this.id
        vehicleType.name = this.name
        return vehicleType
    }
}

export default VehicleTypeDao
