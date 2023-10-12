import {GraphQLError, GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";

const notAuthenticatedError = new GraphQLError('Your are not authenticated', null,
    null,
    null,
    null,
    null,
    { code: 'NOT_AUTHENTICATED', date: Date.now(), status: 401}
);


export default notAuthenticatedError;
