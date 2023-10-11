import UserDao from "../../models/dao/userDao";
import {Query} from "ts-postgres";
import dbService from "../../dbService";
import AddUserDto from "../../models/dto/addUserDto";

class UserDbDataSource {

    async userExists(email: string): Promise<boolean> {
        const query = new Query(
            'SELECT COUNT(*) FROM "user" WHERE email = $1',
            [email]
        )
        const result = await dbService.dbClient.execute(query);
        return result.rows[0][0] as number > 0;
    }

    async getFromCredentials(email: string, password: string): Promise<UserDao | null> {
        const query = new Query(
            'SELECT id, lastname, firstname, birthday_date, email  FROM "user" WHERE email = $1 AND password = sha512($2)',
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

    async addUser(user: AddUserDto): Promise<UserDao> {
        const query = new Query(
            'INSERT INTO "user" (lastname, firstname, email, password, birthday_date) VALUES ($1, $2, $3, sha512($4), $5) RETURNING id',
            [user.lastname, user.firstname, user.email, user.password, user.birthday_date]
        )
        const result = await dbService.dbClient.execute(query);
        return result.rows.map(
            (row: any) => new UserDao(row[0], user.lastname, user.firstname, user.email, user.birthday_date)
        )[0];
    }

}

export default UserDbDataSource
