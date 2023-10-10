import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Brand from "../../../domain/entities/brand";

const userType = new GraphQLObjectType<Brand>({
    name: 'User',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        lastname: { type: GraphQLNonNull(GraphQLString) },
        firstname: { type: GraphQLNonNull(GraphQLString) },
        birthday_date: { type: GraphQLString },
        email: { type: GraphQLNonNull(GraphQLString) }
    },
});

export {userType}
