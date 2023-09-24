import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Brand from "../../../domain/entities/brand";

const brandType = new GraphQLObjectType<Brand>({
    name: 'Brand',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
        logoUri: { type: GraphQLNonNull(GraphQLString) },
    },
})

export {brandType}
