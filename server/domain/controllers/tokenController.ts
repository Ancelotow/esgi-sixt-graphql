import User from "../entities/user";
import jwt = require('jsonwebtoken');

class TokenController {

    generateJwtToken = (user: User) => {
        return jwt.sign({user: user}, process.env.JWT_SECRET, { expiresIn: "2h" })
    }

}

export default new TokenController();
