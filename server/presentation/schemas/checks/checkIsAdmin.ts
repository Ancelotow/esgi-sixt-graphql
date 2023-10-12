import notAuthenticatedError from "../errors/notAuthenticatedError";
import unauthorizedError from "../errors/unauthorizedError";

const checkIsAdmin = (context) => {
    const user = (context.data) ? context.data.user : null;
    if(!user) {
        throw notAuthenticatedError;
    }
    if(!user.isAdmin)  {
        throw unauthorizedError
    }
}

export default checkIsAdmin;
