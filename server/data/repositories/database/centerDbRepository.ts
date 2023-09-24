import CenterRepository from "../../../domain/repositories/centerRepository";
import CenterDbDataSource from "../../data_sources/database/centerDbDataSource";
import Center from "../../../domain/entities/center";

class CenterDbRepository implements CenterRepository {

    private _dataSource: CenterDbDataSource = new CenterDbDataSource();

    async getAll(): Promise<Center[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default CenterDbRepository
