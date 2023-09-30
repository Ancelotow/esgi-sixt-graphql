import TownDao from "../../models/townDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";

class UserDbDataSource {

    async getFromCredentials(email: string, password: string): Promise<UserDao | null> {
        const query = new Query(
            'SELECT id, lastname, firstname, birthday_date, email  FROM "user" WHERE email = $1 AND password = $2',
            [email, password]
        )
        const result = await dbService.dbClient.execute(query);
        if(result.rows.length === 0) {
            return null;
        }
        return result.rows.map(
            (row: any) => new UserDao(row[0], row[1], row[2], row[4], row[3])
        )[0];
    }

}

export default UserDbDataSource