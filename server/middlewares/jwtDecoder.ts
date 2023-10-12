import TokenController from "../domain/controllers/tokenController";

const jwtDecoder = async (req, _, next) => {
    const token = req.headers.authorization;
    if (token) {
        const user = await TokenController.decodeJwtToken(token);
        req.data = {user: user}
    }
    next();
}

export default jwtDecoder;
