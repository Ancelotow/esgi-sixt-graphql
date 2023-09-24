import VehicleTypeRepository from "../../../domain/repositories/vehicleTypeRepository";
import VehicleTypeDbDataSource from "../../data_sources/database/vehicleTypeDbDataSource";
import VehicleType from "../../../domain/entities/vehicleType";

class VehicleTypeDbRepository implements VehicleTypeRepository {

    private _dataSource: VehicleTypeDbDataSource = new VehicleTypeDbDataSource();

    async getAll(): Promise<VehicleType[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default VehicleTypeDbRepository
