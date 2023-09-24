import TownRepository from "../../../domain/repositories/townRepository";
import TownDbDataSource from "../../data_sources/database/townDbDataSource";
import Town from "../../../domain/entities/town";

class TownDbRepository implements TownRepository {

    private _dataSource: TownDbDataSource = new TownDbDataSource();

    async getAll(): Promise<Town[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default TownDbRepository
