import {mutationWithClientMutationId} from "graphql-relay";
import {GraphQLError, GraphQLNonNull, GraphQLString} from "graphql";
import UserController from "../../../domain/controllers/userController";
import {userType} from "../types/userType";
import User from "../../../domain/entities/user";
import invalidError from "../errors/invalidError";

const addUserType = mutationWithClientMutationId({
    name: 'AddUser',
    inputFields: {
        lastname: { type: GraphQLNonNull(GraphQLString) },
        firstname: { type: GraphQLNonNull(GraphQLString) },
        birthday_date: { type: GraphQLString },
        email: { type: GraphQLNonNull(GraphQLString) },
        password: {type: new GraphQLNonNull(GraphQLString)},
    },
    outputFields: {
        user: {type: userType},
    },
    mutateAndGetPayload: async (input) => {
        let isUserExist = await UserController.userExists(input.email);
        if (isUserExist) {
            throw invalidError("User already exists", 'EMAIL_EXIST');
        }

        let user = new User();
        user.lastname = input.lastname;
        user.firstname = input.firstname;
        user.birthdayDate = input.birthday_date;
        user.email = input.email;
        let userAdded =  await UserController.addUser(user, input.password);
        return {user: userAdded};
    },
})

export {addUserType}
