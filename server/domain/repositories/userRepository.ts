import User from "../entities/user";

interface UserRepository {
    getFromCredentials(email: string, password: string): Promise<User | null>;

    addUser(user: User, password: string): Promise<User>;

    userExists(email: string): Promise<boolean>;
}

export default UserRepository;
