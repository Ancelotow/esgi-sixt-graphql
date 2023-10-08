import Vehicle from "../entities/vehicle";

interface VehicleRepository {
    getAll(): Promise<Vehicle[]>;
    getAllFiltered(maximumKilometrage: number|null, minimumPlaces: number|null): Promise<Vehicle[]>;
}

export default VehicleRepository;
