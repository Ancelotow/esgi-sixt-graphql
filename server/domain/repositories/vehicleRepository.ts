import AddVehicleDto from "../../data/models/dto/addVehicleDto";
import Vehicle from "../entities/vehicle";

interface VehicleRepository {
    getAll(): Promise<Vehicle[]>;
    getAllFiltered(maximumKilometrage: number|null, minimumPlaces: number|null): Promise<Vehicle[]>;
    updateVehicle(id: number, kilometrage: number): Promise<Vehicle>
    addVehicle(vehicleInput: AddVehicleDto): Promise<Vehicle>
}

export default VehicleRepository;
