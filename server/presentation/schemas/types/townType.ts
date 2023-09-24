import {GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Town from "../../../domain/entities/town";

const townType = new GraphQLObjectType<Town>({
    name: 'Town',
    fields: {
        inseeCode: { type: GraphQLNonNull(GraphQLString) },
        name: { type: GraphQLNonNull(GraphQLString) },
        zipCode: { type: GraphQLNonNull(GraphQLString) },
    },
});

export {townType}
