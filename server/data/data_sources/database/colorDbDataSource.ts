import ColorDao from "../../models/colorDao";
import dbService from "../../dbService";
import {Query} from "ts-postgres";

class ColorDbDataSource {

    async get(): Promise<Array<ColorDao>> {
        const query = new Query('SELECT id, name, hex FROM color')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new ColorDao(row.id, row.name, row.hex)
        );
    }

}


export default ColorDbDataSource
