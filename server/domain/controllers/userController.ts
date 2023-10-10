import User from "../entities/user";
import UserRepository from "../repositories/userRepository";
import UserDbRepository from "../../data/repositories/database/userDbRepository";

class UserController {

    private repository: UserRepository = new UserDbRepository();

    getFromCredential(email: string, password: string): Promise<User | null> {
        return this.repository.getFromCredentials(email, password);
    }

    addUser(user: User, password: string): Promise<User> {
        return this.repository.addUser(user, password);
    }

    userExists(email: string): Promise<boolean> {
        return this.repository.userExists(email);
    }

}

export default new UserController();
