import Fuel from "../entities/fuel";

interface FuelRepository {
    getAll(): Promise<Fuel[]>;

    getByModel(idModel: number): Promise<Fuel[]>;
}

export default FuelRepository;
