import Vehicle from "../entities/vehicle";

interface VehicleRepository {
    getAll(): Promise<Vehicle[]>;
}

export default VehicleRepository;
