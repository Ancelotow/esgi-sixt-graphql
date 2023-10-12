import notAuthenticatedError from "../errors/notAuthenticatedError";

const checkIsAuthenticated = (context) => {
    const user = (context.data) ? context.data.user : null;
    if(!user) {
        throw notAuthenticatedError;
    }
}

export default checkIsAuthenticated;
