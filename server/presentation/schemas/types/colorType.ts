import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Color from "../../../domain/entities/color";

const colorType = new GraphQLObjectType<Color>({
    name: 'Color',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
        hex: { type: GraphQLNonNull(GraphQLString) },
    },
})

export {colorType}
