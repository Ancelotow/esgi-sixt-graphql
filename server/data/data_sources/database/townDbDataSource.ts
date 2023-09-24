import TownDao from "../../models/townDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class TownDbDataSource {

    async get(): Promise<Array<TownDao>> {
        const query = new Query('SELECT insee_code, name, zip_code FROM town')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new TownDao(row.insee_code, row.name, row.zip_code)
        );
    }

}

export default TownDbDataSource
