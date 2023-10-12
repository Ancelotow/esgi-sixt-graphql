import {GraphQLError} from "graphql";

const unauthorizedError = (message = 'Your are not authorized') => new GraphQLError(
    message,
    null,
    null,
    null,
    null,
    null,
    { code: 'UNAUTHORIZED', date: Date.now(), status: 401}
);

export default unauthorizedError;
