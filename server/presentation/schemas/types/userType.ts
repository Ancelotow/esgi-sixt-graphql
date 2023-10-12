import {GraphQLBoolean, GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Brand from "../../../domain/entities/brand";

const userType = new GraphQLObjectType<Brand>({
    name: 'User',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        lastname: { type: GraphQLNonNull(GraphQLString) },
        firstname: { type: GraphQLNonNull(GraphQLString) },
        birthdayDate: { type: GraphQLString },
        email: { type: GraphQLNonNull(GraphQLString) },
        isAdmin: { type: GraphQLNonNull(GraphQLBoolean) },
    },
});

export {userType}
