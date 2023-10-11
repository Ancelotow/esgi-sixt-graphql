import Vehicle from "../../../domain/entities/vehicle";

class VehicleDao {
    constructor(
        public id: number,
        public number_plate: string,
        public nb_places: number,
        public kilometrage: number,
        public is_air_conditioner: boolean,
        public amount_excluding: number,
        public max_charge: number,
        public max_speed_allowed: number,
        public model_id: number,
        public color_id: number,
        public center_id: number,
        public transmission_id: number,
        public image_uri: string,
    ) {}

    toEntity() {
        let vehicle = new Vehicle()
        vehicle.id = this.id
        vehicle.numberPlate = this.number_plate
        vehicle.nbPlaces = this.nb_places
        vehicle.kilometrage = this.kilometrage
        vehicle.isAirConditioner = this.is_air_conditioner
        vehicle.amountExcluding = this.amount_excluding
        vehicle.maxCharge = this.max_charge
        vehicle.maxSpeedAllowed = this.max_speed_allowed
        vehicle.modelId = this.model_id
        vehicle.colorId = this.color_id
        vehicle.centerId = this.center_id
        vehicle.transmissionId = this.transmission_id
        vehicle.imageUri = this.image_uri
        return vehicle
    }
}

export default VehicleDao
