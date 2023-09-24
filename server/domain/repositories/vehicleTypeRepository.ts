import VehicleType from "../entities/vehicleType";

interface VehicleTypeRepository {
    getAll(): Promise<VehicleType[]>;
}

export default VehicleTypeRepository;
