import {GraphQLError} from "graphql";

const invalidError = (message = 'Invalid error', code = "INVALID") => new GraphQLError(
    message,
    null,
    null,
    null,
    null,
    null,
    { code: code, date: Date.now(), status: 400}
);

export default invalidError;
