import {GraphQLObjectType} from "graphql";
import {loginType} from "./mutators/login";
import {addUserType} from "./mutators/addUser";

export default new GraphQLObjectType({
    name: 'Mutation',
    fields: {
        login: loginType,
        addUser: addUserType,
    }
})
