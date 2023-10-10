import StatusDao from "../../models/dao/statusDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class StatusDbDataSource {

    async get(): Promise<Array<StatusDao>> {
        const query = new Query('SELECT id, name FROM status')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new StatusDao(row[0], row[1])
        );
    }

}

export default StatusDbDataSource
