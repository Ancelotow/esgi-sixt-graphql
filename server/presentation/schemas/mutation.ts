import {GraphQLObjectType} from "graphql";
import {loginType} from "./mutators/login";

export default new GraphQLObjectType({
    name: 'Mutation',
    fields: {
        login: loginType,
    }
})
