import {GraphQLError, GraphQLNonNull, GraphQLString} from "graphql";
import {mutationWithClientMutationId} from "graphql-relay";
import {sessionType} from "../types/sessionType";
import UserController from "../../../domain/controllers/userController";
import TokenController from "../../../domain/controllers/tokenController";


const loginType = mutationWithClientMutationId({
    name: 'Login',
    inputFields: {
        email: {type: new GraphQLNonNull(GraphQLString)},
        password: {type: new GraphQLNonNull(GraphQLString)},
    },
    outputFields: {
        session: {type: sessionType,},
    },
    mutateAndGetPayload: async (input) => {
        let user = await UserController.getFromCredential(input.email, input.password);
        if (!user) {
            throw new GraphQLError('Invalid credentials',
                null,
                null,
                null,
                null,
                null,
                { code: 'UNAUTHORIZED', date: Date.now(), status: 401}
            );
        }

        return {
            session: {
                token: TokenController.generateJwtToken(user),
                user: user,
            }
        }
    },
})

export {loginType}

