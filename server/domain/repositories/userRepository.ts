import User from "../entities/user";

interface UserRepository {
    getFromCredentials(email: string, password: string): Promise<User | null>;
}

export default UserRepository;