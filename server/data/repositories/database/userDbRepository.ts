import UserRepository from "../../../domain/repositories/userRepository";
import User from "../../../domain/entities/user";
import UserDbDataSource from "../../data_sources/database/userDbDataSource";
import AddUserDto from "../../models/dto/addUserDto";

class UserDbRepository implements  UserRepository {

    private _dataSource = new UserDbDataSource();

    async getFromCredentials(email: string, password: string): Promise<User | null> {
        let userDao = await this._dataSource.getFromCredentials(email, password);
        if (userDao) {
            return userDao.toEntity();
        }
        return null;
    }

    async addUser(user: User, password: string): Promise<User> {
        let userDto = new AddUserDto();
        userDto.lastname = user.lastname;
        userDto.firstname = user.firstname;
        userDto.email = user.email;
        userDto.birthday_date = user.birthdayDate;
        userDto.password = password;
        let userDao = await this._dataSource.addUser(userDto);
        return userDao.toEntity();
    }

    async userExists(email: string): Promise<boolean> {
        return await this._dataSource.userExists(email);
    }

}

export default UserDbRepository;
