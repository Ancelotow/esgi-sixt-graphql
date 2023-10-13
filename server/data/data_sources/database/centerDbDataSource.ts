import {Query} from "ts-postgres";
import dbService from "../../dbService";
import CenterDao from "../../models/dao/centerDao";
import AddCenterDto from "../../models/dto/addCenterDto";
import UpdateCenterDto from "../../models/dto/updateCenterDto";

class CenterDbDataSource {

    async get(): Promise<Array<CenterDao>> {
        const query = new Query('SELECT id, name, address, insee_code, is_delete FROM center WHERE is_delete = false')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0], row[1], row[2], row[3], row[4])
        );
    }

    async getById(centerId: number): Promise<CenterDao> {
        const query = new Query('SELECT id, name, address, insee_code, is_delete FROM center WHERE id = $1', [centerId])
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0], row[1], row[2], row[3], row[4])
        )[0];
    }

    async delete(centerId: number): Promise<CenterDao> {
        const query = new Query(
            'UPDATE "center" SET is_delete = true WHERE id = $1 RETURNING id, name, address, insee_code, is_delete',
            [centerId]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0],row[1],row[2],row[3],row[4])
        )[0];
    }

    async update(centerId: number, data: UpdateCenterDto): Promise<CenterDao> {
        let center = await this.getById(centerId);
        if (center == null) { return null }

        const query = new Query(
            'UPDATE "center" SET name = $2, address = $3, insee_code = $4 WHERE id = $1 AND is_delete = false RETURNING id, name, address, insee_code, is_delete',
            [centerId, data.name??center.name, data.address??center.address, data.insee_code??center.insee_code]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new CenterDao(row[0],row[1],row[2],row[3],row[4])
        )[0];
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
