import UserRepository from "../../../domain/repositories/userRepository";
import User from "../../../domain/entities/user";
import UserDbDataSource from "../../data_sources/database/userDbDataSource";

class UserDbRepository implements  UserRepository {

    private _dataSource = new UserDbDataSource();

    async getFromCredentials(email: string, password: string): Promise<User | null> {
        let userDao = await this._dataSource.getFromCredentials(email, password);
        if (userDao) {
            return userDao.toEntity();
        }
        return null;
    }

}

export default UserDbRepository;