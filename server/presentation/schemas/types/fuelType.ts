import {GraphQLID, GraphQLNonNull, GraphQLObjectType, GraphQLString} from "graphql";
import Fuel from "../../../domain/entities/fuel";

const fuelType = new GraphQLObjectType<Fuel>({
    name: 'Fuel',
    fields: {
        id: { type: GraphQLNonNull(GraphQLID) },
        name: { type: GraphQLNonNull(GraphQLString) },
    },
})

export {fuelType}
