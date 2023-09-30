import User from "../entities/user";
import UserRepository from "../repositories/userRepository";
import UserDbRepository from "../../data/repositories/database/userDbRepository";

class UserController {

    private repository: UserRepository = new UserDbRepository();

    getFromCredential(email: string, password: string): Promise<User | null> {
        return this.repository.getFromCredentials(email, password);
    }

}

export default new UserController();