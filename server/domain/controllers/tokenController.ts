import User from "../entities/user";
import jwt = require('jsonwebtoken');

class TokenController {

    generateJwtToken = (user: User) => {
        return jwt.sign({user: user}, process.env.JWT_SECRET, { expiresIn: "2h" })
    }

    decodeJwtToken = async (jwtToken: string) => {
        return new Promise<User|null>((resolve) => {
            const token = jwtToken.split(' ')[1]
            jwt.verify(token, process.env.JWT_SECRET, (err, data) => {
                if (err) {
                    resolve(null)
                } else {
                    resolve(data['user'] as User)
                }
            });
        });
    }

}

export default new TokenController();
