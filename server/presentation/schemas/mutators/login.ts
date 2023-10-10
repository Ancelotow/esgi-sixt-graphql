import {GraphQLNonNull, GraphQLString} from "graphql";
import {mutationWithClientMutationId} from "graphql-relay";
import {sessionType} from "../types/sessionType";
import UserController from "../../../domain/controllers/userController";


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
            // todo: throw error
        }
        return {
            session: {
                token: 'token',
                user: user,
            }
        }
    },
})

