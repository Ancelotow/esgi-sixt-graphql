import {Query} from "ts-postgres";
import dbService from "../../dbService";
import RentDao from "../../models/dao/rentDao";
import CreateRentDto from "../../models/dto/createRentDto";

class RentDbDataSource {

    async get(): Promise<Array<RentDao>> {
        const query = new Query('SELECT id, nb_days, amount_excluding, vat_rate, rent_at, created_at, vehicle_id, user_id, status_id FROM rent')
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new RentDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
        );
    }

    async getByUserId(userId: number): Promise<Array<RentDao>> {
        const query = new Query(
            'SELECT id, nb_days, amount_excluding, vat_rate, rent_at, created_at, vehicle_id, user_id, status_id FROM rent WHERE user_id = $1',
            [userId]
        )
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new RentDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
        );
    }

    async updateRentStatus(rentId: number, statusId: number): Promise<RentDao> {
        const query = new Query(
            'UPDATE rent SET status_id = $1 WHERE id = $2 RETURNING id, nb_days, amount_excluding, vat_rate, rent_at, created_at, vehicle_id, user_id, status_id',
            [statusId,rentId]
        );
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new RentDao(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
        )[0];
    }

    async createRent(rent: CreateRentDto): Promise<RentDao> {
        const query = new Query(
            'INSERT INTO "rent" (nb_days, amount_excluding, vat_rate, rent_at, created_at, vehicle_id, user_id, status_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id',
            [rent.nb_days, rent.amount_excluding, rent.vat_rate, rent.rent_at, rent.created_at, rent.vehicle_id, rent.user_id, rent.status_id]
        )
        const result = await dbService.dbClient.execute(query);
        console.log('Create rent result : ', result);
        return result.rows.map(
            (row: any) => new RentDao(row[0], rent.nb_days, rent.amount_excluding, rent.vat_rate, rent.rent_at, rent.created_at, rent.vehicle_id, rent.user_id, rent.status_id)
        )[0];
    }

}

export default RentDbDataSource
