import Fuel from "../entities/fuel";

interface FuelRepository {
    getAll(): Promise<Fuel[]>;
}

export default FuelRepository;
