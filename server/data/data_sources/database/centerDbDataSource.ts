import {Query} from "ts-postgres";
import dbService from "../../dbService";
import CenterDao from "../../models/dao/centerDao";
import AddCenterDto from "../../models/dto/addCenterDto";

class CenterDbDataSource {

    async get(): Promise<Array<CenterDao>> {
        const query = new Query('SELECT id, name, address, insee_code, is_delete FROM center')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0], row[1], row[2], row[3], row[4])
        );
    }

    async add(center: AddCenterDto): Promise<CenterDao> {
        const query = new Query(
            'INSERT INTO "center" (name, address, insee_code, is_delete) VALUES ($1, $2, $3, false) RETURNING id',
            [center.name, center.address, center.insee_code]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0], center.name, center.address, center.insee_code, false)
        )[0];
    }
}

export default CenterDbDataSource
