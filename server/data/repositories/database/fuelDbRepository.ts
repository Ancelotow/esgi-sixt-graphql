import FuelRepository from "../../../domain/repositories/fuelRepository";
import FuelDbDataSource from "../../data_sources/database/fuelDbDataSource";
import Fuel from "../../../domain/entities/fuel";

class FuelDbRepository implements FuelRepository {

    private _dataSource: FuelDbDataSource = new FuelDbDataSource();

    async getAll(): Promise<Fuel[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default FuelDbRepository
