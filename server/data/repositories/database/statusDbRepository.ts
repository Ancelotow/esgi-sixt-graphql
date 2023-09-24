import StatusRepository from "../../../domain/repositories/statusRepository";
import Status from "../../../domain/entities/status";
import StatusDbDataSource from "../../data_sources/database/statusDbDataSource";

class StatusDbRepository implements StatusRepository {

    private _dataSource: StatusDbDataSource = new StatusDbDataSource();

    async getAll(): Promise<Status[]> {
        let results = await this._dataSource.get();
        return results.map(e => e.toEntity());
    }

}

export default StatusDbRepository
